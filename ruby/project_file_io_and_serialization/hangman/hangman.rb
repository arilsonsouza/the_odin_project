require './game'

class Hangman

  def initialize
    @game = Game.new
  end

  def start
    intro
  end

  private

    def intro
      puts "++++++++++++++++++++++++++++++"
      puts "Vamos jogar o jogo da forca!"
      puts "++++++++++++++++++++++++++++++"
      puts 
      puts "Opções: "
      puts "1. Novo jogo"
      puts "2. Carregar jogo"
      puts "3. Sair"
      print "O que você gostaria de fazer?: "
      choose_option
    end

    def choose_option
      user_option = gets.chomp.downcase.strip.to_i
      case user_option
        when 1
          puts "Inicicando um novo jogo...\n\n"
          @game.play
        when 2
          if @game.from_json 
            @game.play
          else
            @game.clear_display
            puts "Oops!! Nenhum jogo salvo. escholha outra opção."
            intro
          end
        when 3
          exit(1)
        else
        puts "Erro: Opção inválida."
        sleep(2)
        intro
      end

    end

end

hangman = Hangman.new
hangman.start