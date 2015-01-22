require 'json'
require 'thread'
require_relative 'workers/worker'
require_relative 'workers/crawler'
require_relative 'workers/fibonacci'

class JobService

  def initialize(redis, mongodb=nil)
    @redis = redis
    @mongodb = mongodb
  end

  def execute_next_worker()
    if @redis.llen('jobs') > 0
      current_worker_json = JSON.parse(@redis.rpop('jobs'))
      current_worker = Object.const_get(current_worker_json['klazz']).new(current_worker_json['title'], current_worker_json['args'])

      result_id = @mongodb.insert(current_worker.execute())
      puts "Result #{result_id} saved..."

      puts ''
    end
  end

  def add_worker(worker)
    @redis.rpush('jobs', worker.json());

    puts 'Added worker : ' + worker.title
  end

end