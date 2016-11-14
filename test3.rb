require 'uri'
require 'pp'

uri1 = URI("http://logs.omegle.com:80/197136e")
uri2 = URI("http://logs.omegle.com/19721db")
uri3 = URI("http://logs.omegle.com/19721db/1")

pp uri1.path
pp uri2.path.split('/')
pp uri3.path.split('/')

puts uri2.path.split('/').count > 2
puts uri3.path.split('/').count > 2
