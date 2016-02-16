class Api::SuggestController < ApplicationController
  def index
    query = params[:query]
    es = Elasticsearch::Client.new hosts: ["#{APP_SEARCH_CONF['host']}:#{APP_SEARCH_CONF['port']}"], reload_connections: true
    if query
      result = es.suggest index: 'projects02-yyyymmdd',
                          type: 'project',
                          pretty: true,
                          body: {
                            title_project: {
                              text: query,
                              completion: {
                                field: "suggest"
                              }
                            }
                          }
      array = []
      for item in result['title_project'][0]['options'] do
        array.push(
          "label": item['text'],
          "value": item['text']
        )
      end
    end
    render json: { result: array }
  end
end
