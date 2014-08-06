module Enumerable

	def my_each
		return self unless block_given?
		for i in self
			yield(i)
		end
	end

	def my_each_with_index
		return self unless block_given?
		for i in self
			yield(i,index(i))
		end
	end

	def my_select
		return self unless block_given?
		newarray = []
		for i in self
			newarray << i if yield(i) == true
		end
		return newarray
	end

	def my_all?
		a = true
		if block_given?
			for i in self
				return a = false if yield(i) == false
			end
		else
			for i in self
				if i == nil || i == false
					return a = false
				end
			end
		end
		return a
	end

	def my_any?
		self.my_each do |i|
			return true if yield(i) == true
		end
	end

	def my_none?
		a = true
		if block_given?
			self.my_each do |i|
				a = false if yield(i) == true
			end
		else
			self.my_each do |i|
				a = false if i == true
			end
		end
		return a 
	end

	def my_count(int = nil)
		j = 0
		if block_given?
			self.my_each do |i|
				j += 1 if yield(i)
			end
		elsif int == nil
			self.my_each do |i|
				j += 1
			end
		else
			j = int
		end
		return j
	end

#	def my_map
#		j = []
#		if block_given?
#			self.my_each do |i|
#				j << yield(i)
#			end
#		end
#		return j
#	end

	def my_map(proc = nil)
		j = []
		if block_given? && proc
			self.myeach do |i|
				j << proc.call(yield i)
			end
			return j
		if proc
			self.myeach do |i|
				j << proc.call(i)
			end
			return j
		else
			if block_given?
				self.my_each do |i|
					j << yield(i)
				end
			end
			return j
		end
	end


	def my_inject(num = nil)
		j = num.nil? ? false : num
		self.my_each do |i|
			if j
				j = yield(j,i)
			else
				j = i
			end
		end
		return j
	end

	def multiply_els
		  # your code here
	end

end

	# my_each test
array = [1,2,3,4]


array.my_each do |i|
   puts "Value of local variable is #{i}"
end

# my_each_with_index test

array.my_each_with_index do |var,index|
	puts "Index of #{var} is #{index}"	
end

# my_select test

puts [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]


# my_all? test

puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts [nil, true, 99].my_all?                              #=> false

# my_any? test

puts %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
puts [nil, true, 99].any? 

# my_none? test

puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
puts [].my_none?                                           #=> true
puts [nil].my_none?                                        #=> true
puts [nil, false].my_none?                                 #=> true

# my_count test

ary = [1, 2, 4, 2]
puts ary.my_count               #=> 4
puts ary.my_count(2)            #=> 2
puts ary.count{ |x| x%2==0 } 	#=> 3

# my_map test

print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
puts (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

# my_inject test

# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end

puts longest                                        #=> "sheep"


@a = ["a","bit city life","c","hold on tight","e","zzzz","hit me up"]
@b = {a: "bit city life",c: "hold on tight",p: "piratess"}
puts @b.my_map {|a| a[0] == 'h'}




