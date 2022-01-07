class Style < ApplicationRecord
    belongs_to :section, optional: true 
    belongs_to :container, optional: true 
    belongs_to :row, optional: true 
    belongs_to :column, optional: true 
end
