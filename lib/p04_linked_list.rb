require 'byebug'

class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  attr_reader :head, :count

  include Enumerable

  def initialize
    @head = Link.new
    @count = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    temp = @head
    until temp.next.nil?
      temp = temp.next
    end
    temp
  end

  def empty?
    @head.key.nil? && @head.val.nil? && @head.next.nil?
  end

  def get(key)

    temp = @head
    until temp.nil?
      return temp.val if temp.key == key
      temp = temp.next
    end
    nil
  end

  def include?(key)
    key =  get(key)
    return key ? true : false
  end

  def insert(key, val)
    if empty?
      @head.key = key
      @head.val = val
    else
      last.next = Link.new(key,val)
    end
    @count += 1
  end


  def remove(key)
    return nil unless self.include?(key)
    if @head.key == key
      removed_key = @head
      if @head.next.nil?
        @head = Link.new
      else
        @head = @head.next
      end
    else
      self.each do |node|
        # debugger
        if node.next.key == key
          removed_key = node.next
          node.next = node.next.next
        end
      end

    end
    @count -= 1
  end

  def each
    temp = @head
    # debugger
    until temp.nil?
      yield(temp)
      # debugger if temp.next.nil?
      temp = temp.next
    end
    @head
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
