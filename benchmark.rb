#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'json'

POST_URI = URI.parse('http://localhost:4000/api/uploads')

def post_data!
  http = Net::HTTP.new(POST_URI.host, POST_URI.port)
  request = Net::HTTP::Post.new(POST_URI.request_uri, 
            'Content-Type' => 'application/json')
  request.body = {upload: {name: "something"}}.to_json
  resp = http.request(request).body
  JSON.parse(resp)["id"]
end

def status_uri(id)
  URI.parse("http://localhost:4000/api/status/#{id}")
end

def get_status(uri)
  resp = Net::HTTP.get(uri)
  JSON.parse(resp)["status"]
end

def get_status_until_complete!(uri)
  until get_status(uri) == "complete"
    sleep 0.01 # necessary?
    puts "Looping..."
  end
end

# Test case:
# id = post_data!
# puts get_status_until_complete!(status_uri(id))

threads = []
10.times do
  threads << Thread.new do
    start = Time.now.to_f
    Thread.current[:id] = post_data!
    get_status_until_complete!(status_uri(Thread.current[:id]))
    finish = Time.now.to_f
    Thread.current[:time_elapsed] = "#{finish - start}s elapsed"
  end
end

threads.each(&:join)

threads.each do |t|
  puts "id: #{t[:id]}, #{t[:time_elapsed]}"
end
