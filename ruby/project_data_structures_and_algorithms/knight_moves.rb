class Square
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def knight_moves
    [
      Square.new(self.x + 2, self.y + 1),
      Square.new(self.x + 2, self.y - 1),
      Square.new(self.x + 1, self.y + 2),
      Square.new(self.x + 1, self.y - 2),
      Square.new(self.x - 2, self.y + 1),
      Square.new(self.x - 2, self.y - 1), 
      Square.new(self.x - 1, self.y + 2), 
      Square.new(self.x - 1, self.y - 2)
    ].select { |square| square.valid? }
  end

  def valid?
    self.x.between?(0, 8) && self.y.between?(0, 8)
  end

  def ==(other)
    [self.x, self.y] == [other.x, other.y]
  end

  def to_s
    [self.x, self.y].to_s
  end
end

class Node
  attr_reader :square, :parent
  def initialize(square, parent = nil)
    @square = square
    @parent = parent
  end

end


def child_nodes(node)
  node.square.knight_moves.map do |square|
    Node.new(square, node)
  end
end


def get_search_obj(search_obj, root_obj)
  queue = []
  queue <<  root_obj
  loop do
    current = queue.shift
    return current if current.square==(search_obj.square)
    child_nodes(current).each { |child| queue << child }
  end
end

def knight_moves(root_square, search_square)
  root_node = Node.new(root_square)
  search_node = Node.new(search_square)

  result = get_search_obj(search_node, root_node)

  route = []
  route.unshift(search_node.square.to_s)
  current = result.parent
  until current == nil
    route.unshift(current.square.to_s)
    current = current.parent
  end
  
  puts "You made it in #{route.length - 1} moves!  Heres your path: "
  route.each { |i| puts i }
end


knight_moves(Square.new(3,3), Square.new(4,3))
knight_moves(Square.new(0,0), Square.new(3,3))
knight_moves(Square.new(3,3), Square.new(0,0))
knight_moves(Square.new(0,0), Square.new(1,2))