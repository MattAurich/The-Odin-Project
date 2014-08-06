

def bubble_sort_by (array)
	previous = 0
	current = 0
	i = 0
	bob = []
	j = array.length
	while i < j
		
		array.each_with_index do |name, index|
			if index > 0
				previous = array[index-1]
				current = array[index]
				if yield(previous, current) < 0
					array[index] = previous
					array[index-1] = current
				end
			end
		end
		i += 1
		bob[j - i] = array[-1]
		array.pop
	end
	print bob
end


bubble_sort_by(["mr", "hi","hello","hey","bi","lo","mandrake", "person", "below"]) do |left,right|
	right.length - left.length
end
