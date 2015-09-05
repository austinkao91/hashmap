class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_sum = 0
    self.each_with_index do |num, idx|
      hash_sum += num.hash * idx.hash
    end
    hash_sum
  end
end

class String
  def hash
    hash_sum = 0
    self.each_char.with_index do |char, idx|
      hash_sum += char.ord.hash * idx.hash
    end
    hash_sum
  end
end

class Hash
  def hash
    hash_sum = 0
    self.each do |key, value|
    hash_sum += key.hash * value.hash
    end
    hash_sum
  end
end
