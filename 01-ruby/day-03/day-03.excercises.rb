# 1. Modify the CSV application to support an each method
# to return a CsvRow object. Use method_missing on that
# CsvRow to return the value for the column for a given
# header. For example, for the animals.csv file, allow an
# API that works like this:

# csv = RubyCsv.new
# csv.each {|row| puts row.one}
# This should print "lions"

class CsvRow
  attr_accessor :values
  def initialize(headers, values)
    @values = {}
    for i in 0..headers.size() - 1  do
      @values[headers[i]] = values[i]
    end
  end

  def method_missing name, *args
    property = name.to_s
    @values[property]
  end
end

module ActsAsCsvModule
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    attr_accessor :headers, :rows
    def initialize
      read
    end

    def read
      @rows = []
      file = File.new("./day-03/%s.txt" % self.class.to_s.downcase)
      @headers = file.gets.chomp.split(', ')

      file.each do |line|
        @rows << CsvRow.new(@headers, line.chomp.split(', '))
      end
    end

    def each(&block)
      for row in @rows do
        block.call row
      end
    end
  end
end

class RubyCsvExcercise
  include ActsAsCsvModule
  acts_as_csv
end

csv = RubyCsvExcercise.new
csv.each {|row| puts row.one}
