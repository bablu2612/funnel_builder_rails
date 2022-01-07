class Section < ApplicationRecord
  belongs_to :page , optional: true 
  belongs_to :preview , optional: true 
  has_many :containers, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :sec_attributes, dependent: :destroy
end
