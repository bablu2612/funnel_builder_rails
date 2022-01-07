class PageForm < ApplicationRecord
  belongs_to :page
  has_many :page_columns,:dependent => :destroy
end
