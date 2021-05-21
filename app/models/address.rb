class Address < ApplicationRecord
  belongs_to :customer
  
  NUMBER_REGEXP = /\A[0-9]+\z/
  
  validates :postal_code, presence: true, format: { with: NUMBER_REGEXP, message: "は半角数字のみで入力して下さい" }
  validates :address, presence: true
  validates :address_name, presence: true

end
