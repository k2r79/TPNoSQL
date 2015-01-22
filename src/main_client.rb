require 'redis'
require_relative 'job-service/job_service'
require_relative 'job-service/workers/crawler'

redis = Redis.new(:host => '127.0.0.1', :port => 6379)
job_service = JobService.new(redis)

loop do
  puts ''
  puts 'Title :'
  title = gets.chomp()

  puts 'Worker Type [C, F] : '
  command_type = gets.chomp()

  if command_type.include?('C')
    puts 'URL :'
    url = gets.chomp()
    job_service.add_worker(Crawler.new(title, { url: url }))
  elsif command_type.include?('F')
    puts 'Max Value :'
    max_value = gets.chomp.to_i()
    job_service.add_worker(Fibonacci.new(title, { max_value: max_value }))
  end
end
