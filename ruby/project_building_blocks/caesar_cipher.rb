def caesar_cipher(message, shift)
  message_cipher = ''
  message.split('').each do |char|
    char_code = char.ord
    if char_code.between?(65, 90) 
      message_cipher << (65 + (((char_code - 65) + shift) % 26)).chr
    elsif char_code.between?(97, 122)
      message_cipher << (97 + (((char_code - 97) + shift) % 26)).chr
    else
      message_cipher << char
    end
  end
  message_cipher
end

while true do
  system "clear" or system "cls"
  
  print 'Input a message please: '
  message = gets.chomp

  print 'Enter a shift value please (negative values accepted): '
  shift = gets.chomp.to_i

  puts "Your ciphered string: #{ caesar_cipher(message, shift) }"

  puts "-" * 50
  puts "Do you want to stop? (Y) (N)"
  stop =  gets.chomp.upcase
  break if stop == 'Y'

end