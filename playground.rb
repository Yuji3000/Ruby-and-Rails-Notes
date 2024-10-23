array = [1, 2, 3, 2]



# array.each do |num|
#   if num >= 2
#     peek
#     require 'pry'; binding.pry
#   end
# end

# hash = {"odd": 4, "even": 4}

# p hash

# a = ["kitty cat", "dog", "horse"]
# p a.minmax                                  #=> ["albatross", "horse"]
# p a.minmax { |a, b| a.length <=> b.length } #=> ["dog", "albatross"]

# chapter 3 method missing

# class Lawyer
#   def method_missing(method, *args)
#     puts "You called: #{method}(#{args.join(', ')})"
#     puts "(You also passed it a block)" if block_given?
#    end
# end
#   bob = Lawyer.new 
#   bob.talk_simple('a', 'b') do
#   # a block
#   end

# pg 63
# class Roulette
#   def method_missing(name, *args)
#     person = name.to_s.capitalize 
#     super unless %[Bob Frank Bill].include?(person)
#     number = 0
#     3.times do
#       number = rand(10) + 1
#       puts "#{number}..." 
#     end
#     "#{person} got a #{number}" 
#   end
# end

# number_of = Roulette.new 
# puts number_of.bob
# puts number_of.frank

