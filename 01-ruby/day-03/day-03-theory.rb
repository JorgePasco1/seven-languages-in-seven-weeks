#### MetaProgramming ####
# It is possible to completely disable Ruby by redifining, say,
# Class.new. The tradeoff is freedom.

# Open classes are useful when you're building languages
# to encode your own domain. Consider an API that expresses
# all distance as inches:

class Numeric
  def inches
    self
  end

  def feet
    self * 12.inches
  end

  def yards
    self * 3.feet
  end

  def miles
    self * 5280.feet
  end

  def back
    self * -1
  end

  def forward
    self
  end
end

puts 10.miles.back
puts 2.feet.forward
puts 5.yards

#### method_missing ####
class Roman
  def self.method_missing name, *args
    roman = name.to_s
    roman.gsub!("IV", "IIII")
    roman.gsub!("IX", "VIIII")
    roman.gsub!("XL", "XXXX")
    roman.gsub!("XC", "LXXXX")

    roman.count("I") +
    roman.count("V") * 5 +
    roman.count("X") * 10 +
    roman.count("L") * 50 +
    roman.count("C") * 100
  end
end

puts Roman.X
puts Roman.XC
puts Roman.XII
puts Roman.X

#### Modules ####
# The most popular metaprogramming style in Ruby. You can
# literally implement def or attr_accessor with a few lines
# of code in a module. You can also extend class definitions
# in surprising ways. A common technique lets you design your
# own domain-specific language (DSL) to deine your class. The
# DSL defines methods in a module that adds all the methods and
# constants needed to manage a class.

# Simple program to open CSV file based on the name of the class

# class ActsAsCsv
#   def read
#     file = File.new("./day-03/%s.txt" % self.class.to_s.downcase)
#     @headers = file.gets.chomp.split(', ')

#     file.each do |line|
#       @result << line.chomp.split(', ')
#     end
#   end

#   def headers
#     @headers
#   end

#   def csv_contents
#     @result
#   end

#   def initialize
#     @result = []
#     read
#   end
# end

# class RubyCsv < ActsAsCsv
# end

class ActsAsCsv
  def self.acts_as_csv
    define_method 'read' do
      file = File.new("./day-03/%s.txt" % self.class.to_s.downcase)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @result << row.chomp.split(', ')
      end
    end

    define_method 'headers' do
      @headers
    end

    define_method 'csv_contents' do
      @result
    end

    define_method 'initialize' do
      @result = []
      read
    end
  end
end

class RubyCsv < ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect


module ActsAsCsvModule
  # this method will be included whenever this module
  # gets included into another. Remember, a class is a module
  # We extend the target class called "base" (which is gonna be,
  # for example, the RubyCsv class), and that module adds class
  # methods to the class.
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      file = File.new("%.txt" % self.class.to_s.downcase)
      @headers = file.gets.chomp.split(', ')

      file.each do |line|
        @csv_contents << line.chomp.split(', ')
      end
    end

    attr_accessor :headers, :csv_contents
    def initialize
      read
    end
  end
end

class RubyCsv
  include ActsAsCsvModule
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
