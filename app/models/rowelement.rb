class Rowelement < ApplicationRecord
  belongs_to :column
  belongs_to :element
  belongs_to :dataset
end
