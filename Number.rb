class Number < ActiveRecord::Base
  validates :phone_number, numericality: {only_integer: true}
  validates :phone_name, presence: true
  belongs_to :contact

end