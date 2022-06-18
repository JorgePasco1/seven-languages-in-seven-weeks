## Pick a random number. Let a player guess
# the number, telling whether the guess is too
# low or too high.

random_number = rand(10)
while true do
  puts "Guess a number between 0 and 9"
  pick = gets.chomp.to_i
  if pick == random_number
    puts "Correct"
    break
  end
  puts "Too #{pick < random_number ? 'low' : 'high'}"
end
