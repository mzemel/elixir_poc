#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'json'

@request_count = (ENV["REQUESTS"] || 10).to_i
@target = ENV["TARGET"] || "elixir"

def post_uri
  @post_uri ||= if @target == "elixir"
    URI.parse("http://localhost:4000/api/uploads")
  else
    URI.parse("http://localhost:3000/uploads")
  end
end

def post_data!
  http = Net::HTTP.new(post_uri.host, post_uri.port)
  request = Net::HTTP::Post.new(post_uri.request_uri, 
            'Content-Type' => 'application/json')
  request.body = {upload: {name: "something"}}.to_json
  resp = http.request(request).body
  JSON.parse(resp)["id"]
end

# Don't memoize since ivar state is shared across threads
def status_uri(id)
  if @target == "elixir"
    URI.parse("http://localhost:4000/api/status/#{id}")
  else
    URI.parse("http://localhost:3000/status/#{id}")
  end
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

threads = []
@request_count.times do
  threads << Thread.new do
    start = Time.now.to_f
    Thread.current[:id] = post_data!
    get_status_until_complete!(status_uri(Thread.current[:id]))
    finish = Time.now.to_f
    Thread.current[:time_elapsed] = finish - start
  end
end

threads.each(&:join)

total = threads.each do |t|
  puts "id: #{t[:id]}, #{t[:time_elapsed]}s elapsed"
end.map{|t| t[:time_elapsed]}.inject(:+)

puts "#{total / @request_count}s average"
