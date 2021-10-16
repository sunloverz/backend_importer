class Product < ApplicationRecord  
  validates :brand, uniqueness: { scope: :code }
  validates_presence_of :brand, :code, :stock, :cost
end
