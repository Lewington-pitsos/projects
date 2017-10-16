require_relative 'archivist.rb'

class Librarian < DatabaseManager
  attr_accessor :tables

  def initialize(db_name)
    super(db_name)
    self.tables = self.all_tables.values.flatten
  end

  def print_table(name)
    table = self.database.exec "SELECT * FROM #{name}"
    table.each do |row|
      puts row
    end
  end

  def all_tables
    self.database.exec Commands.all_tables
  end

  def table_specs(name)
    puts self.database.exec "\\d #{name}"
  end

  def record_table(name)
    self.tables.push(name)
  end

  def show_all_tables
    self.tables.each do |name|
      print "\r\n---------------------------------------------\r\n"
      self.print_table(name)
    end
  end
end
