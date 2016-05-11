require_relative 'setup'
require_relative 'contact'
require_relative 'seed'





# #!/usr/bin/env ruby

# require 'pry'
# require_relative 'numbers'

# # Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

#   # attr_reader :num_of_phones

def initialize
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "   new     - Create a new contact"
    puts "   list    - List all contacts"
    puts "   show    - Show a contact"
    puts "   search  - Search contacts"
  
  elsif ARGV[0] == "new"
    contact_info = get_names
    contact = Contact.create(name: contact_info[0], email: contact_info[1])
    input = ""  
    loop do
      phone_info = get_numbers
      contact.numbers.create(phone_name: phone_info[0], phone_number: phone_info[1])
      puts "Add another number?"
      input = STDIN.gets.chomp.downcase   
      break if input == "no"
    end
    puts contact.name
    contact.numbers.each {|x| puts "#{x.phone_name}, #{x.phone_number}"} 
  
  elsif ARGV[0] == "list"
    puts "Listing all contacts..."
    Contact.all.each do |contact|
      puts "Name: #{contact.name}, Email: #{contact.email}"
    end

  elsif ARGV[0] == "show" && /\d+/.match(ARGV[1]) 
    puts "Finding specified contact..."
    found_contact = Contact.find(ARGV[1])
    puts found_contact.name

  elsif ARGV[0] == "search" && /\w+/.match(ARGV[1])
    search_term = ARGV[1]
    puts "Searching"
    identified = Contact.where("name LIKE ?", "%#{search_term}%")
    identified.each do |contact|
      puts "Name: #{contact.name}"
    end

  elsif ARGV[0] == "update" && /\d+/.match(ARGV[1]) 
    id = ARGV[1]
    contact = Contact.find(id)
    contact_info = get_names
    contact.name = contact_info[0]
    contact.email = contact_info[1]
    contact.save
    puts "#{contact.name} has been updated!"


  elsif ARGV[0] == "destroy" && /\d+/.match(ARGV[1]) 
    id = ARGV[1]
    the_contact = Contact.find(id)
    the_contact.destroy
    puts "Contact destroyed."
  else 
    puts "Command not recognized."
  end
end

  def get_names
    names = []
    puts "What is the full name?"
    names << STDIN.gets.chomp
    puts "What is the email?"
    names << STDIN.gets.chomp
    names
  end

  def get_numbers
    numbers = []
    puts "What is the name of your phone?"
    numbers << STDIN.gets.chomp
    puts "What is the phone number?"
    numbers << STDIN.gets.chomp
    numbers
  end

end

ContactList.new
