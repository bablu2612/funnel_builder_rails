class PageElement < ApplicationRecord
  belongs_to :column
  has_one :element_style, :dependent => :delete
  has_many :element_attributes, :dependent => :delete_all
  has_many :element_styles, :dependent => :delete_all

end
