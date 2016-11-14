require 'rack/throttle'
require 'sinatra/reloader'
require './config/environments'
require './models'

use Rack::Static, :urls => ["/images", "/javascripts", "/stylesheets", "/fonts"], :root => "assets"
use Rack::Throttle::Daily,    :max => 200

get '/' do
  @log = Log.offset(rand(Log.count)).first['url']
  erb :index
end

get '/random_omeglog' do
  content_type :json
  {url: Log.offset(rand(Log.count)).first['url']}.to_json
end

post '/report_omeglog' do
  url = Rack::Utils.escape_html(params[:url])
  log = Log.find_by_url(url)
  if !log.nil?
    report = log.reports.create!()
    {success: true}.to_json
  else
    {error: 'Log not found.'}.to_json
  end
end
