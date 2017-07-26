class CreateColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :columns do |t|
      t.string :column_name
      t.references :dataset, foreign_key: true

      t.timestamps
    end
  end
end

