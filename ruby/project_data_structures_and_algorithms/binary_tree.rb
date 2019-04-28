class Node
  attr_accessor :value, :parent, :left, :right
  def initialize(value = nil, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end
end

class BinaryTree
  attr_accessor :root
  def initialize(root = nil)
    @root = root
  end
  
=begin
[50, 30, 20, 40, 70, 60, 80]
        50
      /    \
    30      70
    / \     / \
  20  40   60  80
=end
  def build_tree(arr)
    @root = insert_node(nil, arr.shift)
    arr.each { |value| insert_node(@root, value) }
  end

  def insert_node(node, value)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert_node(node.left, value)
      node.left.parent = node
    elsif value > node.value
      node.right = insert_node(node.right, value)
      node.right.parent = node
    end

    return node
  end

  def  breadth_first_search(target_value)
    queue = [@root]
    while !queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    nil
  end

  def depth_first_search(target_value)
    stack = [@root]
    while !stack.empty?
      node = stack.pop
      return node if node.value == target_value
      stack << node.right unless node.right.nil?
      stack << node.left unless node.left.nil?
    end
    nil
  end

  def dfs_rec(target_value, node = @root)
    return node if node.nil? || node.value == target_value
    tmp = dfs_rec(target_value, node.left)
    tmp = dfs_rec(target_value, node.right) unless tmp
    tmp
  end

end

binary_tree = BinaryTree.new
binary_tree.build_tree([50, 30, 20, 40, 70, 60, 80])

puts "BFS: #{binary_tree.breadth_first_search(60).parent.value}"
puts "DFS: #{binary_tree.depth_first_search(40).parent.value}"
puts "DFS REC : #{binary_tree.dfs_rec(40).parent.value}"