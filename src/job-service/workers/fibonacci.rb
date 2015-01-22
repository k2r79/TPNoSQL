require 'open-uri'
require_relative 'worker'

class Fibonacci < Worker

  def process
    super

    puts "Fibonacci up to #{@args['max_value']} ..."

    a = 0
    b = 1
    c = 1

    puts a
    while c < @args['max_value']
      puts c

      c = a + b
      a = b
      b = c
    end
  end

end