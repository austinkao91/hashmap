require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  attr_reader :count
  include Enumerable


  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    @count += 1
    if @count > num_buckets
      resize!
    end
    @store[key.hash % num_buckets].insert(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @count -= 1
    @store[key.hash % num_buckets].remove(key)
  end

  def each
    num_buckets.times do |idx|
      @store[idx].each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    resized_bucket = Array.new(num_buckets*2) {LinkedList.new}
    resize = num_buckets*2
    self.each do |key, val|
      resized_bucket[key.hash%resize].insert(key, val)
    end
    @store = resized_bucket
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
