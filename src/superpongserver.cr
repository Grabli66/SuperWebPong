require "kemal"

port = (ENV["PORT"]? || 8080).to_i

get "/" do |env|
  send_file env, "./html5/bin/index.html"
end

ws "/socket" do |socket|
  socket.send "Hello from Kemal!"
end

public_folder "html5/bin"

Kemal.run port