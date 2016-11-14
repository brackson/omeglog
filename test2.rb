require 'net/http'
require 'net/ping'

threads = Array.new
@proxies = File.readlines("proxy_list.txt").map { |i| i.chomp.split ':' }

def get_valid_proxy
  loop do
    proxy = @proxies.sample
    if Net::Ping::TCP.new(proxy[0], proxy[1]).ping == true
      return proxy
    else
      next
    end
  end
end

10.times do |i|
  threads << Thread.new do
    loop do
      break if @stop_threads == true
      proxy = get_valid_proxy()

      log_id = ([5,7].sample).times.map { [*'0'..'9', *'a'..'z'].sample }.join

      uri = URI('http://logs.omegle.com/' + log_id)
      req = Net::HTTP.new(uri, nil, proxy[0], proxy[1])
      res = req.get(uri)

      if res.code == '200'
        puts '#{log_id} FOUND'
      else
        puts res.code + ' ' + log_id
      end
    end
  end
end

threads.each { |t| t.join }
threads.each { |t| t.exit }

puts @log_id
