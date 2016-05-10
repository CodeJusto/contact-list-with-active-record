require 'pg'

class Contact

  attr_accessor :name, :email, :number, :id

  @@conn = PG.connect({
  host: 'localhost',
  dbname: 'contactdb',
  user: 'development',
  password: 'development'})
  
  def initialize(name, email, id= nil)
    @name = name
    @email = email
    # @number = full_number
    @id = id
  end

  def save
    if id == nil
      @@conn.exec_params("INSERT INTO contactfix (name, email) VALUES ($1, $2);", [name, email])
    else
      @@conn.exec_params("UPDATE contactfix SET name=$1, email=$2 WHERE id=$3;", [name, email, id])
    end
  end

  def destroy
    @@conn.exec_params("DELETE FROM contactfix WHERE id = $1::int;", [id])
  end

  class << self

    def all
        results = []
        @@conn.exec("SELECT * FROM contactfix ORDER BY id;").each do |contact|
          results << create_from_row(contact)
        end
        results
    end

    def create(name, email)

      new_contact = Contact.new(name,email)
      new_contact.save
      create_from_row(@@conn.exec("SELECT * FROM contactfix ORDER BY id DESC LIMIT 1;")[0])
      end
    
    def find(id)
      @@conn.exec_params("SELECT * FROM contactfix WHERE id=$1::int;", [id]).map do |result|
        create_from_row(result)
      end
    end
    
    def search(term)
      term = "%#{term}%"
      @@conn.exec_params("SELECT * FROM contactfix WHERE name LIKE $1;", [term]).map do |result|
        create_from_row(result)
      end
    end

    def create_from_row(c)
      Contact.new(c["name"], c["email"], c["id"])
    end
  end
end


