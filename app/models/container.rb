class Container < ApplicationRecord
  belongs_to :section 
  has_many :rows, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :sec_attributes, dependent: :destroy
end
