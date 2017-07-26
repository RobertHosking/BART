class Column < ApplicationRecord
  has_many :rowelements
  belongs_to :dataset
end
