class Report < ApplicationRecord
  has_many :sections, dependent: :destroy
end
