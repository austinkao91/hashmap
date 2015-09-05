require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key_hash = key.hash
    @count += 1
    resize! if @count > num_buckets
    @store[key_hash % num_buckets] << key
  end

  def include?(key)
    hash_key = key.hash
    @store[hash_key % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized_bucket = Array.new(num_buckets*2) {Array.new}
    resize = resized_bucket.length
    @store.each do |bucket|
      bucket.each do |key|
        resized_bucket[key.hash%resize] << key
      end
    end
    @store = resized_bucket
  end
end
