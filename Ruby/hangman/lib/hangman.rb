require 'yaml'

class Hangman
	attr_accessor :random_word,:word_display,:incorrect_guesses_left,:incorrect_letters
	def initialize
		dictionary = File.readlines "../5desk.txt"
		valid_words = []
		dictionary.each do |word|
			if word.chomp.length > 4 && word.chomp.length < 13
				valid_words << word.chomp.downcase
			end
		end
		@random_word = valid_words[rand(0..valid_words.length)]
		@word_display = Array.new(@random_word.length, '_')
		@incorrect_guesses_left = 6
		@incorrect_letters = []
	end


	def load_game
		content = File.open('games/saved.yaml', 'r') do |file| 
			file.read
		end
		yml = YAML.load(content)
		puts yml.play

	end

	def save_game
		Dir.mkdir('games') unless Dir.exists? 'games'
		filename = "games/saved.yaml"
		File.open(filename, 'w') do |file|
			file.puts YAML.dump(self)
		end
	end

	def play
		until @incorrect_guesses_left == 0
			puts ""
			puts "#{@word_display.join(" ")}      Incorrect guesses: #{@incorrect_letters.join(" ")}"
			puts "Would you like to save game? [Y/N]"
			save_game_question = gets.chomp.downcase
			if save_game_question == 'y'
				self.save_game
			end
			puts "You have #{@incorrect_guesses_left} incorrect guesses before you lose"
			puts "Please guess a letter that belongs to the secret word"
			guess = gets.chomp.downcase

			number_correct = 0

			for i in 0..@incorrect_letters.length
				if guess == @incorrect_letters[i]
					puts ""
					puts "That letter has already shown itself to be wrong, please choose a different letter"
					number_correct = 1
				end
			end

				for j in 0..@random_word.length
					if @word_display[j] == guess
						puts ""
						puts "That letter has already proved to be correct, please try a new letter"
						number_correct += 1
					elsif @random_word[j] == guess
						@word_display[j] = @random_word[j]
						number_correct += 1
					end
				end

			
			if number_correct == 0
				@incorrect_letters << guess
				@incorrect_guesses_left -= 1
			end
			if @random_word == @word_display.join("")
				puts ""
				puts "Congratulations!! You have won the game of Hangman!!!"
				@incorrect_guesses_left = 0
			elsif @incorrect_guesses_left == 0
				puts ""
				puts "I am sorry, the word was #{@random_word}. Better luck next time."
			end

		end

	end




puts "Would you like to load your previous game?? [Y/N]"
load_game_question = gets.chomp.downcase
if load_game_question == 'y'
	a = Hangman.new
	a.load_game
else
	a = Hangman.new
	a.play
end
end

