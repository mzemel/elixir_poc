require "redis"

class Status
  class << self
    def redis
      @redis ||= Redis.new
    end

    def start(id)
      redis.hset("status", "#{id}", "start")
    end

    def complete(id)
      redis.hset("status", "#{id}", "complete")
    end

    def status(id)
      redis.hget("status", "#{id}") || "not found"
    end

    def clear
      redis.flushall
    end
  end
end