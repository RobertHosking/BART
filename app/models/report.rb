class Report < ApplicationRecord
  has_and_belongs_to_many :datasets
  has_many :sections, dependent: :destroy

  def add_dataset(dataset_id)
    d = Dataset.find_by(id: dataset_id)
    self.datasets << d
  end

end
