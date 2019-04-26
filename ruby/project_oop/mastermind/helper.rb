module Helper
  def generate_code
    code = []
    letters = *('A'..'F')
    4.times do 
      letter = letters.sample
      code << letter
      letters.delete(letter)
    end
    code.join('')
  end

  def display_intro(max_rounds = 4)
    puts "Bem vindo ao Mastermind!".center(100) 
    puts "\n\t 1) O objetivo do jogo é adivinhar um código secreto de 4 letras gerado pelo computador."
    sleep 1
    puts "\n\t 2) Você só tem #{ max_rounds } tentativas para quebrar o código."
    sleep 1
    puts "\n\t 3) O computador fornecerá feedback para você após cada palpite."
    sleep 1
    puts "\n\t 4) O código conterá apenas a letras de A-F e nunca uma letra duplicada.."

    hints(0.5)
    sleep 1
    puts "\n\t#{"Exe".magenta }:    O código secreto é AFBD\n\t        Seu palpite é EFCA\n\t        você verá #{"E".red.bold}#{"F".green.bold}#{"C".red.bold}#{"A".yellow.bold}"
  end

  def hints(sleep_time = 0)
    puts "\n\t#{"HINTS".magenta}:".white
    sleep sleep_time
    puts "\t\tUma letra #{"verde".green.bold} indica um palpite correto no local correto.."
    sleep sleep_time
    puts "\t\tUma letra #{"amarela".yellow.bold} indica um palpite correto no lugar errado."
    sleep sleep_time
    puts "\t\tUma letra #{"vermelha".red.bold} indica um palpite errado."
    
  end

end