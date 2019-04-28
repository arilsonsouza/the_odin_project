class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  # adds a new node to the end of the list
  def append(value)
    new_node = Node.new(value)
    @head ? @tail.next_node = new_node  : @head = new_node
    @tail = new_node
    @size += 1
  end

  # adds a new node to the start of the list
  def prepend(value)
    new_node = Node.new(value, @head)
    @tail = new_node unless @head
    @head = new_node
    @size += 1
  end

  # size returns the total number of nodes in the list
  def size
    @size
  end

  # returns the first node in the list
  def head
    @head.nil? ? nil : @head.value
  end

  # returns the last node in the list
  def tail
    @tail.nil? ? nil : @tail.value
  end

  # returns the node at the given index
  def at(index)
    return nil if index < 0 || index > @size 
    temp = @head
    index.times { temp = temp.next_node}
    temp
  end

  # removes the last element from the list
  def pop
    current_node = @head
    prev_node = nil
    while current_node.next_node
      prev_node = current_node
      current_node = current_node.next_node
    end
    @tail = prev_node
    @tail.next_node = nil unless tail.nil?
    @size -= 1
    current_node.value
  end

  # returns true if the passed in value is in the list and otherwise returns false.
  def contains?(value)
    temp = @head
    while temp
      return true if temp.value == value
      temp = temp.next_node
    end
    false
  end

  # returns the index of the node containing data, or nil if not found.
  def find(value)
    index = 0
    temp = @head
    while temp
      return index if temp.value == value
      index += 1
      temp = temp.next_node
    end
    nil
  end

  #represent LinkedList objects as strings.
  def to_s
    str = ''
    temp = @head
    while temp
      str << "( #{temp.value} ) -> "
      temp = temp.next_node
    end
    str << 'nil'
  end

  # that inserts the node at the given index
  def insert_at(data, index)
    return nil if index < 0 || index > @size 
    new_node = Node.new(data, at(index))
    at(index - 1).next_node = new_node
    @size += 1
  end

  #that removes the node at the given index. 
  def remove_at(index)
    return nil if index < 0 || index > @size
    index.zero? ? @head = @head.next_node : at(index - 1).next_node = at(index + 1)
    @size -= 1
  end
end


list = LinkedList.new
list.append(1)
list.append(4)
list.append(5)
list.append(9)
puts list.to_s

list.prepend(2)
list.prepend(10)
list.prepend(11)
puts list.to_s

puts "item at(5): #{list.at(5)}"

list.pop
list.pop
puts "list pop: #{list.to_s}"

puts "list  contains?(10): #{list.contains?(10)}"
puts "list  contains?(155): #{list.contains?(155)}"

puts "list find(1): #{list.find(1)}"

list.insert_at(15, 3)
puts list.to_s

list.remove_at(3)
puts list.to_s