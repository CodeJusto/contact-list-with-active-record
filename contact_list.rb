#!/usr/bin/env ruby

require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

# @counter = 0

def initialize
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "   new     - Create a new contact"
    puts "   list    - List all contacts"
    puts "   show    - Show a contact"
    puts "   search  - Search contacts"
  # Add new contacts
  elsif ARGV[0] == "new"
    puts "Creating new contact"
    puts "What is the full name?"
    full_name = STDIN.gets.chomp
    puts "What is the email?"
    email = STDIN.gets.chomp
    input = ""
    full_number = []
    while input != "no"
      puts "Enter the name of your phone."
      phone_name = STDIN.gets.chomp
      puts "Enter the number for this phone"
      phone_number = STDIN.gets.chomp
      full_number << "#{phone_name}: #{phone_number}"
      # counter += 1
      puts "Do you want to create another number? (yes/no)"
      input = STDIN.gets.chomp.downcase
    end
    new_contact = Contact.create(full_name, email, full_number)
    puts "ID: #{new_contact.id} | Name: #{new_contact.name} | Email: #{new_contact.email} | Phone: #{new_contact.number.compact}"

  # List all contacts
  elsif ARGV[0] == "list"
    puts "Listing all contacts..."
    puts "GETTING HERE!"
    retrieved_array = Contact.all
    counter = 0
    retrieved_array.each do |line| 
      if (counter % 5 == 0) && (counter > 0)
        STDIN.gets
      end
        puts "ID: #{line.id} | Name: #{line.name} | Email: #{line.email} | Phone: #{line.number.compact}"
        counter += 1
    end
  # Show a single contact
  elsif ARGV[0] == "show" && /\d+/.match(ARGV[1]) 
    retrieved_array = Contact.find(ARGV[1])
    # while true
    #   begin
        puts "ID: #{retrieved_array.id} | Name: #{retrieved_array.name} | Email: #{retrieved_array.email} | Phone: #{retrieved_array.number.compact}"
    #     break
    #   rescue
    #     puts "Please enter a new ID"
    #     input = STDIN.gets.chomp
    #     retrieved_array = Contact.find(input)
    #   end
    # end
  # Search for a single contact
  elsif ARGV[0] == "search" && /\w+/.match(ARGV[1])
    retrieved_array = Contact.search(ARGV[1])
    retrieved_array.each do |contact| 
      puts "ID: #{contact.id} | Name: #{contact.name} | Email: #{contact.email} | Phone: #{contact.number.compact}" 
    end
  else 
    puts "Command not recognized."
  end
end
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end

session = ContactList.new
