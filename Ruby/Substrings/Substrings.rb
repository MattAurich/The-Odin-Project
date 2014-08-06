def substrings(words,dictionary)
  hash = {}

  new_words = words.downcase

  dictionary.each do |word|
    hash[word] = new_words.scan(word).count if new_words.include?(word)
  end

  hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below",dictionary)
