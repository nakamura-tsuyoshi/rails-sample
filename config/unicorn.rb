rails_root = File.expand_path('../../', __FILE__)
rails_env = ENV['RAILS_ENV'] || "development"

worker_processes 2
working_directory rails_root

listen 8080
pid "#{rails_root}/tmp/#{rails_env}_unicorn.pid"

stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"
