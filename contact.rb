# require 'pg'

class Contact < ActiveRecord::Base
  validates :name, :email,  presence: true
  validates :email, uniqueness: true

  has_many :numbers

end


