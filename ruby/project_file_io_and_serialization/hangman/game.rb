require 'json'

class Game
  
  def initialize()
    @attempts = 6
    @correct_guesses = []
    @incorrect_guesses = []
    @secret_word = choose_word
    @hidden_word = []
    @guess = ""
    @game_over = false
    @you_won = false
    @is_from_json = false
    @file_name = 'game_state.json'
  end

  def play
    init_hidden_word if !@is_from_json
    print_hangman

    while @attempts != 0
      final_guess = @attempts < 6 || @correct_guesses.length > 0 ? final_guess? : false
      final_guess ? get_user_final_guess : user_guess
      if valid_guess_input?
        check_user_guess
      else
        puts "Ops, parece que você digitou uma entrada ruim.\n Lembre-se, uma letra de cada vez!"
      end

      user_option = user_exit
      case user_option
      when 1
        next
      when 2
        exit(1)
      when 3
        save_game_state
      end

    end
  end

  def from_json
    
    if File.file?(@file_name)
      @is_from_json = true
      json_data = File.read(@file_name)
      game_state = JSON.parse(json_data)
      game_state.each_with_index do |el, i|
        self.instance_variable_set(self.instance_variables[i], el[1])
      end
      true
    else
      false
    end
  end

  def clear_display
    system "clear" or system "cls"
  end

  private

  def as_json(options = {})
    {
      attempts: @attempts,
      correct_guesses: @correct_guesses,
      incorrect_guesses: @incorrect_guesses,
      secret_word: @secret_word,
      hidden_word: @hidden_word
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def user_exit
    puts "\nOpções: "
    puts "1. Continuar"
    puts "2. Sair"
    puts "3. Sair e salvar"
    print "O que você gostaria de fazer?: "
    user_option = gets.chomp.to_i
  end

  def save_game_state
    saved_game = File.open('game_state.json', 'w')
    saved_game.write(to_json)
    puts "Salvando o estado do jogo..."
    sleep(3)
    exit(1)
  end

  def check_user_guess
    if @hidden_word.include?(@guess)
      puts "Que burro: Este palpite já foi dado"
      puts "Agora você desperdiçou uma tentativa"
      update_attempts
      sleep(2)
    elsif @secret_word.include?(@guess)
      @correct_guesses << @guess
      update_hidden_word
    else
      @incorrect_guesses << @guess
      update_attempts
    end
    print_hangman
    is_winner?
  end

  def update_attempts
    @attempts -= 1
    game_over if @attempts == 0
  end

  def update_hidden_word
    @secret_word.each_char.with_index do |char, index|
      @hidden_word[index] = char == @guess ? char : @hidden_word[index]
    end
  end

  def is_winner?
    @you_won = @hidden_word.none?{ |char| char == '*'}
    game_over if @you_won
  end

  def user_guess
    print "\nDigite o palpite: "
    @guess = gets.chomp.to_s.downcase
  end

  def init_hidden_word
    @secret_word.each_char do |char|
      @hidden_word << "*"
    end
  end

  def print_hangman
    hangman_array = ["
      +---+
      |   |
          |
          |
          |
          |
    =========
    ", "
      +---+
      |   |
      O   |
          |
          |
          |
    =========", "
      +---+
      |   |
      O   |
      |   |
          |
          |
    =========", "
      +---+
      |   |
      O   |
     /|   |
          |
          |
    =========", "
      +---+
      |   |
      O   |
     /|\\  |
          |
          |
    =========", "
      +---+
      |   |
      O   |
     /|\\  |
     /    |
          |
    =========", "
      +---+
      |   |
      O   |
     /|\\  |
     / \\  |
          |
    ========="]

    clear_display
    puts "secret_word: #{@secret_word}"
    if @attempts == 0
      puts hangman_array[-1]
    else
      puts hangman_array[-@attempts-1]
    end
    print_hidden_word
  end

  def print_hidden_word
    puts ""
    @hidden_word.each do |char|
      print "#{char} "
    end
    puts "\nRestam #{@attempts} tentativas."
    print_user_guesses('Palpites certos: ', @correct_guesses) if @correct_guesses.length > 0
    print_user_guesses('Palpites errados: ', @incorrect_guesses) if @incorrect_guesses.length > 0
  end

  def print_user_guesses(label, guesses)
    print "#{label}"
    guesses.each do |guess|
      print "#{guess} "
    end
    puts ""
  end

  def choose_word
    File.readlines('5desk.txt').select { |word| word.length.between?(4,5)}.shuffle.sample.downcase.strip
  end

  def valid_guess_input?
    @guess =~ /[[:alpha:]]/ && @guess.length == 1
  end

  def final_guess?
    print "Já sabe qual é a palavra? (S/n): "
    gets.chomp.downcase == 's'
  end

  def get_user_final_guess
      print "\nInforme a palavra: "
      secret_word_guess = gets.chomp.downcase
      @you_won = secret_word_guess == @secret_word
      game_over
  end

  def game_over
    if @you_won
      puts "Você venceu! A palavra foi \"#{@secret_word}\"!!"
    else
      puts "Você perdeu! A palavra foi \"#{@secret_word}\".\nMelhor sorte da próxima vez!"
    end
    File.delete(@file_name) if File.exist?(@file_name)
    exit(1)
  end

end