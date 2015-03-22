#!/usr/bin/env ruby
require 'bundler/setup'
require 'future_value'

f = FutureValue.new

if f.has_value?
  puts "yes"
else
  puts "no"
end

threads = Array.new
3.times do |i|
  threads << Thread.new do
    until f.has_value?
      sleep 0.1
    end
    puts "Thread #{i} got #{f.value}"
  end
end



puts f.has_value?

sleep 2
f.value = "Hello"

puts f.value

puts f.has_value?


threads.each { |t| t.join }