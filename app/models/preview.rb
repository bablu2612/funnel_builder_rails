class Preview < ApplicationRecord
    has_many :sections,:dependent => :destroy
end
