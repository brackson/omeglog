require 'sinatra/activerecord/rake'
require 'net/http'
require 'uri'

namespace :db do
  task :load_config do
    require "./app"
  end
end

namespace :scrape do
  require './models'
  require './config/environments'

  desc 'Scrape web.archive.org for Omegle logs'
  task :wayback do
    doc = Net::HTTP.get(URI('http://web.archive.org/cdx/search/xd?url=logs.omegle.com/*&fl=timestamp,original,statuscode&output=json'))
    parsed = JSON.parse(doc)
    count = 0

    parsed[1..-1].each do |log|
      #> log = ["timestamp","original","statuscode"]
      next if log[2] != '200'

      uri = URI(log[1])
      break if uri.path.split('/').count > 2

      new_log = Log.new(url: uri.path.split('/').last)

      if new_log.save
        count += 1
        puts 'created log: ' + uri.path
      else
        next
      end
    end

    puts count.to_s + ' records created!'
  end

  desc 'Scrape reddit.com for submitted Omegle logs'
  task :reddit do
    doc = Net::HTTP.get(URI('http://www.reddit.com/domain/logs.omegle.com/new.json?sort=new'))
    parsed = JSON.parse(doc)

    parsed['data']['children'].each do |post|
      log_id = post['data']['url'].split('/')[-1]
      if !(Log.exists?(url: log_id))
        log = Log.new(url: log_id)
        if log.save
          puts log_id
        end
      end
    end
  end
end
