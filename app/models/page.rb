class Page < ApplicationRecord
  belongs_to :funnel
  has_many :sections,:dependent => :destroy
  has_many :page_forms,:dependent => :destroy
end
