class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
        t.boolean :active
        t.boolean :raw
        t.string :term
        t.string :year
        t.string :name
        t.integer :permission
        t.string :csv

        t.string :base_path
        t.string :original_file
        t.string :yaml_file
        t.string :working_file
        t.text :columns
      t.timestamps
    end
  end
end
