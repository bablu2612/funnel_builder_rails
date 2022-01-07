class UserDetail < ApplicationRecord
    belongs_to :user
    validates_length_of :phone, minimum: 6, maximum:12, allow_blank: true,format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
end
