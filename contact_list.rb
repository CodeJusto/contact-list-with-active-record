#!/usr/bin/env ruby

require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

def initialize
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "   new     - Create a new contact"
    puts "   list    - List all contacts"
    puts "   show    - Show a contact"
    puts "   search  - Search contacts"
  # Add new contacts
  elsif ARGV[0] == "new"
    contact_info = get_info
    new_contact = Contact.create(contact_info[0], contact_info[1])  
    display(new_contact)

  elsif ARGV[0] == "list"
    puts "Listing all contacts..."
    contacts = Contact.all
    contacts.each do |contact|
      display(contact)
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
    input = get_info
    contact.name = input[0]
    contact.email = input[1]
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

  def display(contact)
    puts "ID: #{contact.id}, Name: #{contact.name}, Email: #{contact.email}"
  end

  def get_info
    info = []
    puts "What is the full name?"
    info << STDIN.gets.chomp
    puts "What is the email?"
    info << STDIN.gets.chomp
    info
  end
end

session = ContactList.new
