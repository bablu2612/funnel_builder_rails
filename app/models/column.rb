class Column < ApplicationRecord
  belongs_to :row 
  has_many :page_elements, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :sec_attributes, dependent: :destroy
end
