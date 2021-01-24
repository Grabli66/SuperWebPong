require "kemal"

port = (ENV["PORT"]? || 8080).to_i

get "/" do |env|
  send_file env, "./bin/html5/bin/index.html"
  #(Dir.entries ".").to_s
end

ws "/socket" do |socket|
  socket.send "Hello from Kemal!"
end

public_folder "./bin/html5/bin"

Kemal.run port