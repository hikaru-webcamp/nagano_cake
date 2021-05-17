class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  
  validates :quantity, numericality: { greater_than_or_equal_to: 1}
end
