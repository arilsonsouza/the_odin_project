
class TicTacToe
  
  def initialize()
    @board = Board.new

    @player_x = Player.new("Player X", :x, @board)
    @player_y = Player.new("Player O", :o, @board)

    @current_player = @player_x
  end

  def play
    loop do
      @board.render

      @current_player.get_coordinates
      
      break if check_game_over?

      switch_players
    end
  end

  private
    def check_game_over?
      check_victory? || check_draw?
    end

    def check_victory?
      if @board.winning_combination?(@current_player.piece)
        @board.render
        puts "Congratulations #{@current_player.name}, you win!"
        true
      else
        false
      end
    end

    def check_draw?
      if @board.full?
        puts "Bummer, you've drawn..."
        true
      else
        false
      end
    end

    def switch_players
      if @current_player == @player_x
        @current_player = @player_y
      else
        @current_player = @player_x
      end
    end

end

class Player
  attr_accessor :name, :piece

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end

  def get_coordinates
    loop do
        coordinates = ask_for_move
        break if @board.add_piece(coordinates, @piece)
    end
  end

  def ask_for_move
    print 'Enter a number between 1 and 9 to make your move: '
    human_move = gets.chomp
    human_move_to_coordinate(human_move)
  end

  private 
    def human_move_to_coordinate(human_move)
      mapping = {
        "1" => [0, 0],
        "2" => [0, 1],
        "3" => [0, 2],
        "4" => [1, 0],
        "5" => [1, 1],
        "6" => [1, 2],
        "7" => [2, 0],
        "8" => [2, 1],
        "9" => [2, 2]
      }
      mapping[human_move]
    end

end

class Board
    attr_accessor :board

    def initialize()
      @board = Array.new(3){Array.new(3)}
    end

    def render
      system "clear" or system "cls"
      puts "+---+---+---+"
      board.each_with_index do |row, row_index|
        print "| "
        row.each_with_index do |col, col_index|
          if col.nil?
            print col_index + (row_index * 3) + 1
          else
            print col.to_s
          end
          print " | "
        end
        puts "\n+---+---+---+"
      end 
    end
 
    def add_piece(coords, piece)
      if coordinates_available?(coords)
        board[coords[0]][coords[1]] = piece
        true
      else
        puts "Invalid moviment. Please choose another location"
        false
      end
    end

    def coordinates_available?(coords)
      @board[coords[0]][coords[1]].nil?
    end

    def winning_combination?(piece)
      winning_diagonal?(piece)   || 
      winning_horizontal?(piece) || 
      winning_vertical?(piece)
    end

    def full?
      @board.all? do |row|
        row.none?(&:nil?)
      end
    end

    private
      def winning_horizontal?(piece) 
        @board.each { |row| return true if all_equal?(row, piece)}
        false
      end

      def winning_vertical?(piece)
        @board.transpose.each { |row| return true if all_equal?(row, piece) }
        false
      end

      def winning_diagonal?(piece) 
       left_diagonal?(piece) || right_diagonal?(piece)
      end

      def all_equal?(row, piece)
        row.all? { |x| x == piece }
      end

      def left_diagonal?(piece)
        (0..2).collect { |i| board[i][i] }.all? { |x| x == piece }
      end

      def right_diagonal?(piece)
        (0..2).collect { |i| board[i][-i-1] }.all? { |x| x == piece }
      end

end

t = TicTacToe.new

t.play
