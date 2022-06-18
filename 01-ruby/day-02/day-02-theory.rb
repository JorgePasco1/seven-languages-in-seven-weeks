# Functions always return something, if not explicit
# it's the last line expression.
def tell_the_truth
  true
end

# Arrays
animals = ['lions', 'tigers', 'bears']
puts animals
puts animals[0]
puts animals[2]
puts animals[10]
puts animals[-1]
puts animals[-2]
puts animals[0..1]
puts (0..1).class

# [] is actually a method on Array
puts [1].class
puts [1].methods.include?(:[])

# Hashes
numbers = {1 => 'one', 2 => "two"}
puts numbers
puts numbers[1]
puts numbers[2]
# A symbol is an identifier preceeded with a colon.
stuff = {:array => [1, 2, 3], :string => 'Hi mom!'}
puts stuff[:string]

puts 'string'.object_id
puts 'string.'.object_id
puts :string.object_id
puts :string.object_id

# We can simulate named parameters with hashes
def tell_the_truth2(options={})
  if options[:profession] == :lawyer
    'It could be believed that thios is almost certainly not false'
  else
    true
  end
end

puts tell_the_truth2
puts tell_the_truth2( :profession => :lawyer )

# A code block is a function without a name.
# You can pass it as a parameter to a function or a method
3.times { puts 'hiya there, kiddo' }
# You can specify code blocks with {/} or do/end.
# Convetion: braces for one line do end for more than one
animals = ['lions and ', 'tigers and ', 'bears', 'oh my']
animals.each {|a| puts a}

# We can open an existing class and add a method
puts 3.class
class Integer
  def my_times
    i = self
    while i > 0
      i = i - 1
      yield
    end
  end
end
3.my_times {puts 'mangy moose'}

# Blocks can be first-class parameters
def call_block(&block)
  block.call
end
def pass_block(&block)
  call_block(&block)
end
pass_block {puts 'Hello, block'}

# Defining classes
puts 4.class
puts 4.class.superclass
puts 4.class.superclass.superclass
puts 4.class.superclass.superclass.superclass
puts 4.class.superclass.superclass.superclass.superclass

class Tree
  attr_accessor :children, :node_name

  def initialize(name, children=[])
    @children = children
    @node_name = name
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new(
  "Ruby",
  [Tree.new("Reia"), Tree.new("MacRuby")]
)

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}

# Ruby uses modules as an alternative to multiple inheritance,
# which can be problematic.

module ToFile
  def filename
    "object_#{self.object_id}.txt"
  end
  def to_f
    File.open(filename, 'w') {|f| f.write(to_s)}
  end
end

class Person
  include ToFile
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
end

puts Person.new('matz').to_f
