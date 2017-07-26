class CreateRowelements < ActiveRecord::Migration[5.0]
  def change
    create_table :rowelements do |t|
      t.integer :row_number
      t.references :column, foreign_key: true
      t.references :element, foreign_key: true
      t.references :dataset, foreign_key: true

      t.timestamps
    end
  end
end
