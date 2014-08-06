


def bubble_sort (array)
	previous = 0
	current = 0
	i = 0
	bob = []
	j = array.length
	while i < j
		
		array.each_with_index do |number, index|
			if index > 0
				previous = array[index-1]
				current = array[index]
				if previous > array[index]
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

bubble_sort([4,3,78,2,0,2])
