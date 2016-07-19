# This script will work on luck and have very little inteligence to try to find a sting.
# We will use a randomly selected set of charaters to find a sentance.

# word to match
word = "to be"

char_array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
guess = []
tries=0

start = Time.now
until guess.join == word
	guess.clear
	for i in 0...word.length
		guess.push(char_array[rand(char_array.length)])
	end
	tries += 1
	#puts "#{tries}:#{guess.join}"
end
puts "Monkey tried #{tries} to find \"#{guess.join}\""
puts Time.now - start