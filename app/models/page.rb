class Page < ApplicationRecord
belongs_to :section
has_many :cards
end
