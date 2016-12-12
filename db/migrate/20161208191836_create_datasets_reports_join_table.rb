class CreateDatasetsReportsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets_reports, id: false do |t|
      t.belongs_to :dataset, index: true
      t.belongs_to :report, index: true
    end
  end
end
