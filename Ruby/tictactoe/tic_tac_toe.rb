module TicTacToe	
	class Players
		attr_accessor :player1, :player2
		def initialize

		end

		def player1
			puts "Please enter the name of one of the players"
			@player1 = gets.chomp
		end

		def player2
			puts "Please enter the name of the other player"
			@player2 = gets.chomp
		end
	end

	class Game
		attr_accessor :players, :board, :current_player, :other_player
		def initialize(players = Players.new, board = Board.new)
			@player1 = players.player1
			@player2 = players.player2
			@players = [@player1,@player2]
			@board = board
			@current_player, @other_player = @players.shuffle
			@current_player = [@current_player, "X"]
			@other_player = [@other_player, "O"]
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def solicit_move
			"#{current_player[0]}: Enter a number between 1 and 9 to make your move"
		end

		def get_move(human_move = gets.chomp)
			a = [human_move.to_i] 
			if a.any? { |integer| integer > 0 && integer < 10 }
				human_move_to_coordinate(human_move)
			else
				puts "WRONG!"
				@r = false
			end
		end

		def human_move_to_coordinate(human_move)
			mapping = {
				"1" => [0,0],
				"2" => [0,1],
				"3" => [0,2],
				"4" => [1,0],
				"5" => [1,1],
				"6" => [1,2],
				"7" => [2,0],
				"8" => [2,1],
				"9" => [2,2]
			}
			mapping[human_move] 
		end

		def game_over_message
			return "Congratulations #{@current_player[0]}! You have won the game of Tic Tac Toe!!!" if board.game_over == :winner
			return "The game ended in a tie!" if board.game_over == :draw
		end

		def play
			board.default_grid
			puts "#{@current_player[0]} has been selected to go first"
			puts board.show_grid
			while true do
				@r = true
				puts solicit_move
				x, y = get_move
				if @r == true
					if board.set_cell(x, y, @current_player[1])
						puts ""
						puts board.show_grid
						if board.game_over
							return puts game_over_message
						else
							switch_players
						end
					end
				end
			end
		end
	end

	class Board
		attr_accessor :grid
		def initialize
			@grid = grid
		end

		def default_grid
			@grid = Array.new(3) { Array.new(3) }
			cell_number = 1
			@grid.each_with_index do |element,index1| 
				element.each_with_index do |element,index2|
					@grid[index1][index2] = cell_number
					cell_number += 1
				end
			end
		end

		def get_cell(x,y)
			grid[x][y]
		end

		def set_cell(x, y, value)
			unless grid[x][y] == "X" || grid[x][y] == "O"
				grid[x][y] = value
			else
				puts "Choose one that has not been taken!!!"
				return false
			end
			
		end

		def show_grid
		 	puts " #{grid[0][0]} | #{grid[0][1]} | #{grid[0][(0-2).abs]}"
			puts "---+---+---"
			puts " #{grid[1][0]} | #{grid[1][(1-2).abs]} | #{grid[1][2]}"
			puts "---+---+---"
			puts " #{grid[2][(2-2).abs]} | #{grid[2][1]} | #{grid[2][2]}"
		end

		def game_over
			return :winner if winner?
			return :draw if draw?
			false
		end

		def winner?
			token = "X"
			for m in 0..1
				l_to_r = 0
				r_to_l = 0

				for i in 0..2
					if grid.transpose[i][0..2].all? { |value| value == token } == true
						return true
					elsif grid[i][0..2].all? { |value| value == token } == true
						return true
					end
					if grid[i][i] == token
						l_to_r += 1
						if l_to_r == 3
							return true
						end
					end
					if grid[i][(i - 2).abs] == token
						r_to_l += 1
						if r_to_l == 3
							return true
						end
					end
				end
				token = "O"
			end
			return false
		end

		def draw?
			grid.flatten.all? { |value| value == "X" || value == "O" }
		end
	end
end


b = TicTacToe::Game.new
b.play








