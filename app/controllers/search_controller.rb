class SearchController < ApplicationController
  def kuromoji
    query = params[:query]
    page  = params[:page] ? params[:page] : 1
    if query
      es = Elasticsearch::Client.new hosts: ["#{APP_SEARCH_CONF['host']}:#{APP_SEARCH_CONF['port']}"], reload_connections: true
      result = es.search index: 'projects02-yyyymmdd',
                         type: 'project',
                         pretty: true,
                         body: {
                           query: {
                             multi_match: {
                               query: query,
                               type: "best_fields",
                               fields: ["title", "detail","returns.return_title","returns.contents"],
                               operator: "and"
                               #tie_breaker: "0.3"
                             }
                           },
                           highlight: {
                             pre_tags: ["<mark>"],
                             post_tags: ["</mark>"],
                             fields: {
                               "returns.return_title": {},
                               "returns.contents": {},
                               "title": {},
                               "detail": {}
                             }
                           }
                         }
      @query = query
      total = result['hits']['total']
      @result = Kaminari.paginate_array(result['hits']['hits'], total_count: total).page(page).per(10)
      @total = total
    end
  end
end
