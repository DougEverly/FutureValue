# FutureValue

A threadsafe future implementation that blocks caller until a value is set.


## Usage

### Create a future value object

    future = FutureValue.new
    future.value = 10
    
### Create a future value object with value

If the value is known at instantiation time, can pass the value. This is more efficient and will prevent blocking.

    future = FutureValue.new(10)

### Check if FutureValue has a value (non-blocking)

    until future.has_value?
      sleep 1
    end
    value = future.value
    
### Wait until future has a value (blocking)

    value = future.value

## Example

    require 'future_value'

    f = FutureValue.new

    t = Thread.new do
      sleep 2
      f.value = 4
    end

    if f.has_value?
      puts "yes"
    else
      puts "no"
    end

    3.times do |i|
      Thread.new do
        puts "Thread #{i} got #{f.value}"
      end
    end

    puts f.value

    puts f.has_value?

## Contributing

1. Fork it ( https://github.com/[DougEverly]/future_value/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
