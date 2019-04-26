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

  def display_intro
    puts "Bem vindo ao Mastermind!".center(100) 
    puts "\n\t 1) O objetivo do jogo é adivinhar um código secreto de 4 letras gerado pelo computador."
    sleep 1
    puts "\n\t 2) Você só tem 6 tentativas para quebrar o código."
    sleep 1
    puts "\n\t 3) O computador fornecerá feedback para você após cada palpite."
    sleep 1
    puts "\n\t 4) O código conterá apenas a letras de A-F e nunca uma letra duplicada.."

    puts "\n\t#{"HINTS".magenta}:".white
    sleep 0.5
    puts "\t\tUma letra #{"verde".green.bold} indica um palpite correto no local correto.."
    sleep 0.5
    puts "\t\tUma letra #{"amarela".yellow.bold} indica um palpite correto no lugar errado."
    sleep 0.5
    puts "\t\tUma letra #{"vermelha".red.bold} indica um palpite errado."
    sleep 2
    puts "\n\t#{"Exemplo:".magenta } O código secreto é AFBD\n\t         Seu palpite é EFCA\n\t         você verá #{"E".red.bold}#{"F".green.bold}#{"C".red.bold}#{"A".yellow.bold}"
  end

end