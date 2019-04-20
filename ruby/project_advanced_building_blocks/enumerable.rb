module Enumerable

  def my_each
    if self.class == Array
      for i in (0..self.length - 1) do
        yield(self[i])
      end
    elsif self.class == Hash
      for i in (0..self.keys.length - 1) do
        yield(self.keys[i], self.values[i])
      end
    end
  end

  def my_each_with_index
    if self.class == Array
      for i in (0..self.length - 1) do
        yield(self[i], i)
      end
    elsif self.class == Hash
      for i in (0..self.keys.length - 1) do
        yield(self.keys[i], self.values[i], i)
      end
    end
  end

  def my_select
    if self.class == Array
      new_array = []
      self.my_each do |value|
        if yield(value)
          new_array << value 
        end
      end
      new_array
    elsif self.class == Hash
      new_hash = {}
      self.my_each do |key, value|
        if yield(key, value)
          new_hash[key] = value
        end
      end
      new_hash
    end
  end

  def my_all?
    if self.class == Array
      self.my_each do |value|
        if !yield(value)
          return false
        end
      end
    elsif self.class == Hash
      self.my_each do |key, value|
        if !yield(key, value)
          return false
        end
      end
    end
    true
  end
 
  def my_any?
    if self.class == Array
      self.my_each do |value|
        if yield(value)
          return true
        end
      end
    elsif self.class == Hash
      self.my_each do |key, value|
        if yield(key, value)
          return true
        end
      end
      false
    end
  end

  def my_none?
    if self.class == Array
      self.my_each do |value|
        if yield(value)
          return false
        end
      end
    elsif self.class == Hash
      self.my_each do |key, value|
        if yield(key, value)
          return false
        end
      end
      false
    end
    true
  end

  def my_count
    count = 0
    if self.class == Array
      self.my_each do |value|
        if yield(value)
          count += 1
        end
      end
    elsif self.class == Hash
      self.my_each do |key, value|
        if yield(key, value)
          count += 1
        end
      end
    end
    count
  end

  def my_map(proc = '')
    
    if self.class == Array
      new_array = []
      if proc.is_a? (Proc)
        self.my_each_with_index do |value, i|
          new_array[i] = proc.call(value)
        end
      else
        self.my_each_with_index do |value, i|
          new_array[i] = yield(value)
        end
      end
      new_array
    elsif self.class == Hash
      new_hash = {}
      if proc.is_a? (Proc)
        self.my_each do |key, value|
          new_hash[key] = proc.call(key, value)
        end
      else
        self.my_each do |key, value|
          new_hash[key] = yield(key, value)
        end
      end
      new_hash
    end
  end

  def my_inject(x)
    total = x
    if self.class == Array
      self.my_each do |value|
        total = yield(total, value)
      end
    elsif self.class == Hash
      self.my_each do |key, value|
        total = yield(total, value)
      end
    else
    end
    total
  end

end