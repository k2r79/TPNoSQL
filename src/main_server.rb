require 'redis'
require 'mongo'
require_relative 'job-service/job_service'
require_relative 'job-service/workers/worker'

redis = Redis.new(:host => '127.0.0.1', :port => 6379)

mongodb = Mongo::Connection.new
db = mongodb['jobs']
collection = db['job-results']

job_service = JobService.new(redis, collection)

loop do
  job_service.execute_next_worker()
end