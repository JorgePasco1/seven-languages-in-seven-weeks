# 1. Find out how to access file with and without code block
# Without code block
FILE_NAME = "./object_70261466929380.txt"
file = File.open(FILE_NAME)
file_data = file.read
puts file_data

# With code block
File.foreach(FILE_NAME) { |line| puts line }
# Benefit: More concise code, we can directly access what we need from it

###########################################################################
# 2. How would you translate a hash to an array? Can you translate arrays
# to hashes?
# Hash to Array
# Possible, it gives an array of 2-dimension arrays, being the first element
# the key, and the second one the value.
hash = {
  :a => "Example a",
  :b => "Example b"
}

hash_arr = hash.to_a
p hash_arr
# [[:a, "Example a"], [:b, "Example b"]]

# Array to Hash?
# Possible, but not ideal, it takes the uneven elements as keys and the even
# as values.
array = ["a", "b", "c", "d"]
arr_hash = Hash[*array.flatten]
p arr_hash
#{"a"=>"b", "c"=>"d"}

# We can define an array of 2-dimension arrays to create a senseful hash, though.
two_dim_arr = [["a", "c"], ["b", "d"]]
arr_hash = Hash[*array.flatten]
p arr_hash

###########################################################################
# 3. Can you iterate through a hash?
# Yes. Using each
h = { "first_name" => "John", "last_name" => "Doe" }
h.each do |key, value|
  puts "#{key} => #{value}"
end

###########################################################################
# 4. You can use Ruby arrays as stacks. What other common data structures do arrays
# support?
# Queue, set, tuple
