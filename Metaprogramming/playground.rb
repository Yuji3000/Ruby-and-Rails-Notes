array = [1, 2, 3, 2]



# array.each do |num|
#   if num >= 2
#     peek
#     require 'pry'; binding.pry
#   end
# end

# hash = {"odd": 4, "even": 4}

# p hash

a = ["kitty cat", "dog", "horse"]
p a.minmax                                  #=> ["albatross", "horse"]
p a.minmax { |a, b| a.length <=> b.length } #=> ["dog", "albatross"]