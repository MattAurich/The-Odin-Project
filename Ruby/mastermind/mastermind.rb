module Mastermind
	class Board
		attr_accessor :code_peg, :key_peg, :grid, :guess, :color_choices, :code, :turn_counter 
		def initialize
			@guess = []
			@code = []
			@code_peg = Array.new(13){["1","2","3","4"]}
			@key_peg = Array.new(13){["a","b","c","d"]}
			@grid = grid
			@color_choices = color_choices
			@r = 0
			@b = 0
			@turn_counter = 1
		end

		def show_row(code_peg = @code_peg, key_peg = @key_peg, guesserid = 1, q = 1)
			if guesserid == 1
				i = 0
				while i < @r + 1
					grid =  "| #{key_peg[i][0]} #{key_peg[i][1]} || #{code_peg[i][0].upcase} #{code_peg[i][1].upcase} #{code_peg[i][2].upcase} #{code_peg[i][3].upcase} || #{key_peg[i][2]} #{key_peg[i][3]} |"
					puts grid
					i +=1
				end
			else
				grid =  "| #{key_peg[q][0]} #{key_peg[q][1]} || #{code_peg[q][0].upcase} #{code_peg[q][1].upcase} #{code_peg[q][2].upcase} #{code_peg[q][3].upcase} || #{key_peg[q][2]} #{key_peg[q][3]} |"
				puts grid 
			end

		end

		def random_selection_mapping
			mapping = {
				1 => "T",
				2 => "G",
				3 => "B",
				4 => "Y",
				5 => "P",
				6 => "O"
			}
			mapping[rand(1..6)]
		end

		def code_makers_code_creator
			i = 0
			4.times do
				@code[i] = self.random_selection_mapping
				i += 1
			end
			puts @code
		end

		def show_the_code
			@code
		end

		def game_over
			return :winner if winning_conditions
			return :loser if losing_conditions
			false
		end

		def game_over_message
			return "Congratulations you have won the game of Mastermind!" if self.game_over == :winner
			return "Try your luck next time!!!" if self.game_over == :loser
		end

		def winning_conditions
			victory_counter = 0
			key_peg[@r-1].all? do |element|
				if element == "R"
					victory_counter += 1
				end
			end
			if victory_counter >= 4
				return true
			else
				return false
			end
		end

		def losing_conditions
			@turn_counter += 1
			if @turn_counter > 12
				return true
			else
				return false
			end
		end
	
		def color_match(code_peg = @code_peg, key_peg = @key_peg, code = @code)
			i = 0
			4.times do	
				if code.any? { |e| e.upcase == code_peg[@b][i].upcase }
					key_peg[@b][i] = "W"
				end
				i += 1
			end
		end

		def color_and_position_match(code_peg = @code_peg, key_peg = @key_peg, code = @code)
			i = 0
			4.times do
				if code_peg[@b][i].upcase == code[i].upcase
					key_peg[@b][i] = "R"
				end
				i += 1
			end
			@b += 1
		end

		def acceptable_colors
			@color_choices = ["T","G","B","Y","P","O"]
		end

		def show_color_map 
			puts "valid colors to choose from: T eal, G reen, B lue, Y ellow, P urple, O range"
			puts "the colors for the keys are: R ed and W hite"
		end

		def default_row_values
		end

		def start_end_row
			puts "  ----------------------"
		end

		def spacer_row
			puts "| ----------------------|"
		end

		def color_prompts
			i = 1
			puts "Attempt number #{@turn_counter}"
			4.times do 
				puts "Enter your guess for space number #{i}"
				@code_peg[@r][i-1] = gets.chomp
				unless @color_choices.any? { |e| @code_peg[@r][i-1].upcase == e }
					puts "That is not a valid color choice!"
					self.show_color_map
					redo
				end

				i += 1
			end
			@r += 1
		end
	end

	class Player 
		attr_accessor :the_choice
		def initialize 
			@the_choice = the_choice
		end

		def creator_or_guesser_prompt
			puts "Do you wish to be the CREATOR or GUESSER in the game of Mastermind?!?!"
		end

		def  player_choice(choice = gets.chomp)
			if choice.upcase == "CREATOR"
				@the_choice = :creator
			elsif choice.upcase == "GUESSER"
				@the_choice = :guesser
			else
				puts "That is an invalid choice..."
				self.creator_or_guesser_prompt
				self.player_choice
			end
		end

	end

	class ComputerAI
		attr_accessor :board, :code, :code_peg, :key_peg
		def initialize(board = Board.new)
			@board = board
			@code = Array.new(4)
			@code_peg = Array.new(13){ ["1","2","3","4"] }
			@key_peg = Array.new(13){["a","b","c","d"]}
			@color_choices = board.acceptable_colors
			@r = 0

		end

		def computer_guess
				i = 0
				q = 4
				while i < q
					j = 0
					if @r > 0 && @key_peg[@r-1][i] == "R"
						@code_peg[@r][i] = @code_peg[@r-1][i]
					elsif @r > 0 && i > 0 && @key_peg[@r-1][i] == "W" && @key_peg[@r-1][i-1] != "R" 
						@code_peg[@r][i-1] = @code_peg[@r-1][i]
						@code_peg[@r][i] = board.random_selection_mapping
						until j > 12 do
							if @code_peg[j][i] == @code_peg[@r][i] && j != @r
								@code_peg[@r][i] = board.random_selection_mapping
								j = -1
							end
							j += 1
						end
					elsif @r > 0 && i == 0 && @key_peg[@r-1][i] == "W" && @key_peg[@r-1][i+3] != "R" 
						@code_peg[@r][i+3] = @code_peg[@r-1][i]
						q = 3
						@code_peg[@r][i] = board.random_selection_mapping
						until j > 12 do
							if @code_peg[j][i] == @code_peg[@r][i] && j != @r
								@code_peg[@r][i] = board.random_selection_mapping
								j = -1
							end
							j += 1
						end
					else
						@code_peg[@r][i] = board.random_selection_mapping
						until j > 12 do
							if @code_peg[j][i] == @code_peg[@r][i] && j != @r
								@code_peg[@r][i] = board.random_selection_mapping
								j = -1
							end
							j += 1
						end
					end
					i += 1
				end
			board.color_match(@code_peg, @key_peg, @code)
			board.color_and_position_match(@code_peg, @key_peg, @code)
			board.show_row(@code_peg, @key_peg, 2, @r)
			@r += 1
		end

		def code_creation
			i = 1
			4.times do
				puts "Please enter the color of the code for position #{i}"
				@code[i-1] = gets.chomp
				unless @color_choices.any? { |e| @code[i-1].upcase == e }
					puts "That is not a valid color choice!"
					board.show_color_map
					redo
				end
				i += 1
			end
		end

	end

	class Game
		attr_accessor :board, :player, :computerai, :the_choice
		def initialize(board = Board.new, player = Player.new, computerai = ComputerAI.new) 
			@board = board
			@player = player
			@computerai = computerai
			player.creator_or_guesser_prompt
			@the_choice = player.player_choice
		end

		def guesser?
			if @the_choice == :creator
				return false
			elsif @the_choice == :guesser
				return true
			end
		end

		def play 
			board.acceptable_colors
			if self.guesser?
				board.code_makers_code_creator
			else
				board.show_color_map
				computerai.code_creation
			end
			for j in 0..12 
				if self.guesser?
					board.show_row
					board.show_color_map
					board.color_prompts
					board.color_match
					board.color_and_position_match
					if board.game_over
						puts board.game_over_message
						if self.guesser?
							print "the code was #{board.show_the_code}"
						end
						break
					end
				else
					computerai.computer_guess
				end
				
			end
		end

	end

end

a = Mastermind::Game.new
a.play



