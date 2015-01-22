require 'json'

class Worker

  attr_reader :title, :args

  def initialize(title, args)
    @title = title
    @args = args
    @results = nil
  end

  def execute()
    puts "Executing #{@title} with args #{@args} ..."

    process()

    return @results
  end

  def process()

  end

  def json()
    return {
        title: @title,
        args: @args,
        klazz: self.class.to_s
    }.to_json()
  end

end