# This script will work on luck and have very little inteligence to try to find a sting.
# We will use a randomly selected set of charaters to find a sentance.

# word to match
word="to be"

class Monkey
	@@char_array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
	@@answered = false
	@@answered_signal = Mutex.new
	def initialize(string_to_guess, monkey_number)
		@string = string_to_guess
		@monkey = monkey_number
		self.guess
		self.present_answer
	end

	def guess
		@start = Time.now
		@guess = []
		@tries = 0
		until @guess.join == @string
			if @@answered
				@finish = Time.now - @start
				puts "Monkey #{@monkey} tried #{@tries} in #{@finish} and failed"
				raise "answered"
			else
				@guess.clear
				for i in 0...@string.length
					@guess.push(@@char_array[rand(@@char_array.length)])
				end
				@tries += 1
			end
			#puts "#{tries}:#{guess.join}"
		end
		@@answered_signal.synchronize {@@answered = true}
		@finish = Time.now - @start
	end

	def present_answer
		puts "Monkey #{@monkey} says it took #{@finish} seconds and #{@tries} tries to find #{@guess.join}\n"
	end
end

thread_array = Array.new
threads = 2

for index in 0...threads
	thread_array[index] = Thread.new(word,index+1) {|word,number|Monkey.new(word, number)}
end

while true
	if thread_array.empty?
		exit 0
	else
		thread_array.each{|t|
			if t.status == false || t.status == nil
				thread_array.delete(t)
			end
		}
	end
end