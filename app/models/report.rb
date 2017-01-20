class Report < ApplicationRecord
  has_many :sections, dependent: :destroy
  serialize :datasets,Array
end
