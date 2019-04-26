require_relative './helper'
require_relative './colorize'

class Game
  include Helper

  def initialize
    @combination = generate_code
    @current_round = 0
    @max_rounds = 6
    @combination_size = 4
    @guesses = {}
    @winner = false
  end

  def play
    
    display_intro(@max_rounds)
    loop do

      player_input
      if valid_input?
        @guesses[@current_round] = @player_combination
        @current_round += 1
        
        clear_display
        
        hints

        analyze

        if game_over?
          game_ended
          break
        end

      else
        puts "\t\tPor favor informe uma combinação válida de 4 letras de A-F"
      end

    end
  end

  private

    def analyze
      puts "\n\t\t-----------------------------------"
      puts "\t\t| # |   Palpite   |   Resultado   |"
      @guesses.each do |key, guess|
        puts "\t\t-----------------------------------"
        puts "\t\t| #{key + 1} |  #{display_guess(guess)}   |   #{display_guess(guess, true)}    |"
      end
      puts "\t\t-----------------------------------"
    end

    
    def display_guess(guess, colorize = false)
      display_str = ''
      
      for i in (0..guess.length - 1) do
        if colorize
          if guess[i] == @combination[i]
            display_str << " #{guess[i]}".green
          elsif @combination.include?(guess[i])
            display_str << " #{ guess[i] }".yellow
          else
            display_str << " #{ guess[i] }".red
          end
        else
          display_str << " #{ guess[i] }"
        end
      end
      display_str
    end
    
    def player_input
      print "\n\t\tDigite seu palpite (ABCDEF): "
      @player_combination = gets.chomp
    end
    
    def valid_input?
      @player_combination =~ /^[A-F]{4}$/ && !@player_combination.each_char.find { |c| @player_combination.count(c) > 1 }
    end

    def game_over?
      @winner = @player_combination == @combination
      @winner || @current_round >= @max_rounds
    end

    def game_ended
      if @winner
        puts "\n\t\tMuito bem! \n\t\tVocê achou o código: #{ @combination }".green
      else
        puts "\n\t\tDesculpe, você não descobriu o código! \n\t\tO código era: #{ @combination }".red
      end

    end

    def clear_display
      system "clear" or system "cls"
    end
end

g = Game.new
g.play