require "kemal"

port = (ENV["PORT"] || 8080).to_i

get "/" do
  "Hello World!"
end

ws "/socket" do |socket|
  socket.send "Hello from Kemal!"
end

Kemal.run port