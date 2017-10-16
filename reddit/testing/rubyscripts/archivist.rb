require 'pg'

require_relative 'psql_commands.rb'

class DatabaseManager
  attr_accessor :name, :database
  def initialize(db_name)
    self.name = db_name
    self.database = PG.connect(dbname: db_name)
  end
end

class Archivist < DatabaseManager
  # interacts with the current database by storing information through PG

  def insert(table, column, value)
    self.database.exec "INSERT INTO #{table} (#{column}) VALUES ('#{value}');"
  end

  def delete_matches(table, column, value)
    if !column && !value
      self.database.exec("DELETE FROM #{table}")
    elsif column || value
      raise "wrong number of truthy arguments supplied to #{self}.delete_matches"
    else
      self.database.exec("DELETE FROM #{table} WHERE #{column}='#{value}'")
    end
  end

end
