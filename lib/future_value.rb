require "future_value/version"
require "thread"

class FutureValue
  def initialize
    @value = nil
    @mutex = Mutex.new
    @condvar = ConditionVariable.new
    @has_value = false
  end
  
  def has_value?
      @has_value
  end
  
  def value
    @mutex.synchronize {
      return @value if @has_value
      @condvar.wait(@mutex)
      return @value
    }
  end
  
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
