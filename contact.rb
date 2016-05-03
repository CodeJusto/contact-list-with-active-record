require 'csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

class IncorrectID < StandardError

end

  attr_reader :id
  attr_accessor :name, :email, :number
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, full_number, id= nil)
    raise 'IDs must be greater than 0 (and also numbers)!' if id && id.to_i <= 0
    @name = name
    @email = email
    @number = full_number
    @id = id
    # TODO: Assign parameter values to instance variables.
  end

  def generate_id
    @id = CSV.read("contacts.csv").length+1
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      # CSV.read("file") returns an array based on each line of the CSV. We are then creating a new 
      # array using map USING elements of each row from the CSV.
      CSV.read("contacts.csv").map {|row| Contact.new(row[1],row[2],row[0].to_i)} 
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email, full_number)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      final_array = []
      new_contact = Contact.new(name,email,full_number)
      CSV.open("contacts.csv", "a") do |csv|
        raise "That email is already in the system and cannot be created" if search(new_contact.email).empty? == false
        csv << [new_contact.generate_id, new_contact.name, new_contact.email, new_contact.number].flatten
      end
      new_contact
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
        # binding.pry
      # while id && id.to_i <= CSV.read("contacts.csv").length + 1
        # begin 
          full_array = CSV.read("contacts.csv").map {|row| Contact.new(row[1],row[2],row[0].to_i)}.select {|contact| contact.id == id.to_i} 
        # rescue NoMethodError
        #   puts "There was a problem with the contact. Please re-enter"
        #   id = gets.chomp
        # else NoMethodError
        #   break
        # end
      # end
      full_array[0]
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      full_array = CSV.read("contacts.csv").map {|row| Contact.new(row[1],row[2],row[0])}.select do |contact| 
        contact.name.include?(term) || contact.email.include?(term)
      end 
      full_array
    end

  end

end
