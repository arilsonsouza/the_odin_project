def substrings(string, dictionary)
  string.downcase!
  substrings_frequencies = Hash.new
  dictionary.each do |word|
    matches = string.scan(/#{word}/).count
    substrings_frequencies[word] = matches if matches > 0
  end
  substrings_frequencies
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
