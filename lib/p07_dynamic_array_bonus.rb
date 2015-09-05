class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
    @capacity = capacity
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @capacity
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    idx = 0
    while idx < @count
      return true if @store[idx] == val
      idx += 1
    end
    false
  end

  def push(val)
    @count += 1
    resize! if @count > capacity
    @store[@count-1] = val
  end

  def unshift(val)
    @count += 1
    resize! if @count > capacity
    idx = count
    p "Capacity is #{capacity} and count is #{@count}"
    while idx > 0
      @store[idx] = @store[idx-1]
      idx -= 1
    end
    @store[0] = val
  end

  def pop
  end

  def shift
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    resized_array = StaticArray.new(capacity*2)
    resize = capacity * 2
    i = 0
    while i < @store.length
      resized_array[i] = @store[i]
      i += 1
    end
    @store = resized_array
  end
end
