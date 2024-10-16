# array = [1, 2, 3, 2]

# p array.tally

even, odd = [1, 2, 3, 4, 5, 6].partition { |n| n.even? }
p even
p odd