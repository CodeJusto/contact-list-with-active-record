require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

def initialize
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "   new     - Create a new contact"
    puts "   list    - List all contacts"
    puts "   show    - Show a contact"
    puts "   search  - Search contacts"
  elsif ARGV[0] == "new"
    puts "new"
  elsif ARGV[0] == "list"
    puts "Listing all contacts..."
    p Contact.all
    # puts "--"
    # puts "#{Contact.contact_array} records total."
  elsif ARGV[0] == "show"
    puts "show"
  elsif ARGV[0] == "search"
    puts "search"
  end
end
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end

session = ContactList.new