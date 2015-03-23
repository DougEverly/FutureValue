require "future_value/version"
require "thread"

class FutureValue
  
  # Initializes new FutureValue
  # Pass value if known at instantiation
  def initialize(*args)
    if args.size == 1
      @value = args.first
      puts "Init value is #{@value}"
      @has_value = true
    else
      @value = nil
      @has_value = false
      @mutex = Mutex.new
      @condvar = ConditionVariable.new
      @timeout = nil
    end
    
  end
  
  # Returns true if FutureValue has a value
  def has_value?
      @has_value
  end
  
  # Returns the value if has a value
  # Blocks until a value it set
  def value
    if @has_value
      return @value
    else
      @mutex.synchronize {
        @condvar.wait(@mutex, @timeout)
        return @value
      }
    end
  end
  
  # Set a value
  # Signal waiting threads that value is present
  def value=(value)
    @mutex.synchronize {
      if has_value?
        raise "Already has a value"
      else
        @value = value
        @has_value = true
        @condvar.broadcast
      end
      @value
    }
  end
end
