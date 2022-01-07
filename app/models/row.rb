class Row < ApplicationRecord
    belongs_to :container 
    has_many :columns, dependent: :destroy
    has_many :styles, dependent: :destroy
    has_many :sec_attributes, dependent: :destroy
end
