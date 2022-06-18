# 1. Print the contents of an array of sixteen numbers, four numbers at a time
# using just "each". Now, do thesame with each_slice in Enumerable
arr = Array.new(16) { rand(1..20) }
p arr

# With each
i = 0
arr.each do |item|
  p arr[i, 4] if (i % 4 == 0)
  i +=1
end

# With each_slice
arr.each_slice(4) { |a| p a }

###################################################################################
# 2. The Tree class was interesting, but it did not allow you to specify a new tree
# with a clean UI. Let the initializer accept a nested structure of hashes. You
# should be able to specify a tree like this:
# {
#  'grandpa' => {
#    'dad' => {
#      'child 1' => {},
#      'child 2' => {},
#      'uncle' => {},
#      'child 3' => {},
#      'child 4' => {}
#    }
#  }
# }
class Tree
  attr_accessor :children, :node_name

  def initialize(structure)
    @name = "root"
    @children = [];

    if structure.size() == 1
      @name = structure.keys()[0]

      structure[@name].each {|key, value| @children.push(Tree.new({key => value}))}
    else
      structure.each{|key, value| @children.push(Tree.new({key => value}))}
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

example = Tree.new({
 'grandpa' => {
   'dad' => {
     'child 1' => {},
     'child 2' => {},
     'uncle' => {},
     'child 3' => {},
     'child 4' => {}
   }
 }
})

p example


###################################################################################
# 3. Write a simple grep that will print the lines of a file
# having any occurences of a phrase anywhere in that line.
# You will ned to do a simple regular expression match and
# read the lines from a file. If you want, include line #s.

def grep(filename, search_phrase)
  line_number = 1
  File.readlines(filename).each do |line|
    if line.match(search_phrase)
      puts "%d %s" % [line_number, line]
    end
    line_number += 1
  end
end

grep('./day-02/excercise-3-input.txt', 'vestibulum')
