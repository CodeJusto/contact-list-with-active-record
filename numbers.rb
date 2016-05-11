class Numbers

  attr_accessor :contact_id, :phone_name, :phone_number, :id

  @@conn = PG.connect({
  host: 'localhost',
  dbname: 'contactdb',
  user: 'development',
  password: 'development'})

  def initialize(contact_id, name, number, id=nil)
    @contact_id = contact_id
    @phone_name = name
    @phone_number = number
    @id = id
  end

  def save
    # binding.pry
      @@conn.exec_params("INSERT INTO numbers (contact_id, phone_name, phone_number) VALUES ($1, $2, $3);", [contact_id, phone_name, phone_number])
    # else
      # @@conn.exec_params("UPDATE numbers SET contact_id=$1, phone_name=$2, phone_number=$3 WHERE id=$4;", [contact_id, phone_name, phone_number])
    # end
  end

  class << self

    def hookup(foreign_key)
      results = []
      @@conn.exec_params("SELECT * FROM numbers LEFT OUTER JOIN contactfix ON numbers.id=$1 ORDER BY numbers.id;",[foreign_key]).each do |contact|
        results << create_from_row(contact)
      end
      # binding.pry
      results
    end


    def create(foreign_id, name, number)
      # binding.pry
      new_number = Numbers.new(foreign_id, name, number)
      puts name
      puts number
      new_number.save
      create_from_row(@@conn.exec_params("SELECT * FROM numbers WHERE contact_id = $1", [foreign_id])[0])
    end

    def create_from_row(c)
      Numbers.new(c["id"], c["phone_name"], c["phone_number"])
    end
  end
end