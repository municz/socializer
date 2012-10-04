require 'sinatra'
require 'sinatra-websocket'
require 'json'
require 'cgi'

set :server, 'thin'
set :twitter_sockets, []
set :facebook_sockets, []
set :public_folter, 'public'

def connect_to_ws(sockets)
  request.websocket do |ws|
    ws.onopen do
      sockets << ws
    end
    ws.onmessage do |msg|
      EM.next_tick { sockets.each{|s| s.send(msg) } }
    end
    ws.onclose do
      sockets.delete(ws)
    end
  end
end

def send_message_to_ws(sockets)
  data = JSON.parse(request.body.read)
  sockets.each do |s|
    s.send(CGI.escapeHTML("@#{data['username']}: #{data['text']}"))
  end
  "Sent"
end

get '/' do
  redirect "index.html"
end

get '/twitter' do
  connect_to_ws(settings.twitter_sockets)
end

post '/tweet' do
  send_message_to_ws(settings.twitter_sockets)
end

get '/facebook' do
  connect_to_ws(settings.facebook_sockets)
end

post '/facebook' do
  send_message_to_ws(settings.facebook_sockets)
end
