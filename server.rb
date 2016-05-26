require 'webrick'
require 'json'

server = WEBrick::HTTPServer.new(Port: 8000)
trap 'INT' do server.shutdown end

server.mount_proc '/' do |req, res|
    res.body = "<h1>Hello, world</h1>"
end

server.mount_proc '/echo' do |req, res|
    post = JSON.parse(req.body)
    res.body = "<h1>{{#{post['value']}}}</h1>"
end

count = 0
server.mount_proc '/counter' do |req, res|
    count += 1
    res.body = "<h1>Counter hit #{count} times</h1>"
end

server.start
