#!/usr/bin/env ruby

require_relative 'contact'
require 'pry'
require_relative 'numbers'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # attr_reader :num_of_phones

def initialize
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "   new     - Create a new contact"
    puts "   list    - List all contacts"
    puts "   show    - Show a contact"
    puts "   search  - Search contacts"
  # Add new contacts
  elsif ARGV[0] == "new"
    contact_info = get_names
    # phone_info = get_numbers
    # @num_of_phones = phone_info.length
    # if Contact.search(contact_info[1]).empty? == false
    #   puts "That email already exists!"
    # else
      contact_base_info = Contact.create(contact_info[0], contact_info[1])  
      # binding.pry
      counter = 0
      # @num_of_phones.times do
        # contact_phone_info = Numbers.create(contact_base_info.id.to_i, phone_info[counter], phone_info[counter+1])
        # counter +=2
      # end
      display(contact_base_info)
    # end
  elsif ARGV[0] == "list"
    puts "Listing all contacts..."
    contacts = Contact.all
    contacts.each do |contact|
      display(contact)
      # Numbers.hookup(contact.id)
    end

  elsif ARGV[0] == "show" && /\d+/.match(ARGV[1]) 
    puts "Finding specified contact..."
    test = Contact.find(ARGV[1])
    display(test[0])

  elsif ARGV[0] == "search" && /\w+/.match(ARGV[1])
    puts "Searching"
    identified = Contact.search(ARGV[1])
    identified.each do |contact|
      display(contact)
    end

  elsif ARGV[0] == "update" && /\d+/.match(ARGV[1]) 
    id = ARGV[1]
    contact = Contact.find(id)[0]
    input = get_names
    # phone = get_phone
    contact.name = input[0]
    contact.email = input[1]
    # contact.phone = phone[0]
    # contact.phone = phone[1]
    contact.save
    display(contact)

  elsif ARGV[0] == "destroy" && /\d+/.match(ARGV[1]) 
    id = ARGV[1]
    the_contact = Contact.find(id)
    the_contact[0].destroy
    puts "Contact destroyed."
  else 
    puts "Command not recognized."
  end
end

  def display(contact, phone=nil)
    puts "ID: #{contact.id}, Name: #{contact.name}, Email: #{contact.email}"
    # if phone.nil? == false
    #   # @num_of_phones.times do
    #     puts "Phone name: #{phone.phone_name}, Phone number: #{phone.phone_number}"
    # end
  end

  def get_names
    names = []
    puts "What is the full name?"
    names << STDIN.gets.chomp
    puts "What is the email?"
    names << STDIN.gets.chomp
    names
  end

  # def get_numbers
  #   numbers = []
  #   loop do
  #     puts "What is the name of your phone?"
  #     numbers << STDIN.gets.chomp
  #     puts "What is the phone number?"
  #     numbers << STDIN.gets.chomp
  #     puts "Add another number?"
  #     input = STDIN.gets.chomp.downcase
  #     break if input == "no" 
  #   end
  #   numbers
  # end

end

session = ContactList.new
