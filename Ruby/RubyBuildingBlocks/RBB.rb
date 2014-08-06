puts "Enter string of characters please"
  string = gets.chomp
puts "Enter the SHIFT FACTOR!!!"
  sfactor = gets.chomp


string.length.times do |letter|

  if string[letter].ord == 90 && sfactor.to_i > 0
    string[letter] = 64.+(sfactor.to_i).chr
  elsif string[letter].ord == 122 && sfactor.to_i > 0
    string[letter] = 96.+(sfactor.to_i).chr
  else
    string[letter] = string[letter].ord.+(sfactor.to_i).chr
  end
end

puts string
