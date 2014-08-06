require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing..."
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "Please enter a tweet that is less than or equal to 140 characters!!!"
		end
	end

	def followers_list
		screen_names = @client.followers.collect { |follower| follower.screen_name }
	end

	def spam_my_followers(message)
		followers_list.each { |name| dm(name, message) }
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message:"
		puts message
		message = "d @#{target} #{message}"
		if followers_list.include?(target)
			tweet(message)
		else
			puts "You can only direct message people that follow you"
		end
	end

	def everyones_last_tweet
		friends = @client.friends
		friends = friends.sort_by { |friend| friend[0] }
		friends.each do |friend|
			message = friend.status.text
			timestamp = friend.status.created_at
			puts "#{friend.user_name} said this on #{timestamp.strftime("%A, %b %d")}"
			puts "#{message}"
			puts ""
		end
	end

	def shorten(original_url)
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		bitly.shorten(original_url).short_url
	end

	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
			when 'q' then puts "Goodbye!"
			when 't' then tweet(parts[1..-1].join(" "))
			when 'dm' then dm(parts[1], parts[2..-1].join(" "))
			when 'spam' then spam_my_followers(parts[1..-1].join(" "))
			when 'elt' then everyones_last_tweet
			when 's' then shorten(parts[1])
			when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
			else
				puts "Sorry, I dont know how to #{command}"
			end
		end
	end
end

blogger = MicroBlogger.new

blogger.run

