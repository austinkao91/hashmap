require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @store.count
  end

  def get(key)
    # debugger

    if @map.include?(key)
      link = @map.get(key)
      value = link.val
      update_link!(link)
    else
      value = calc!(key)
    end
    p "next access"
    p "count #{count}"
    @store.each do |node|
      p "#{node.key} #{node.val}"
    end
    value
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    puts 'calc'
    value = @prc.call(key)
    @store.insert(key, value)
    @map.set(key, @store.last)
    eject! if count > @max
    value
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
    @map.set(link.key, @store.last)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
