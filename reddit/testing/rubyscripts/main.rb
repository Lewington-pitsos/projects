require_relative 'librarian.rb'

joe = Archivist.new('testdb')

# joe.insert('comments', 'name', 'PLACEHOLDER')

# joe.delete_matches('comments', false, 'PLACEHOLDER')

lin = Librarian.new('testdb')

lin.show_all_tables

lin.print_table('comments')
