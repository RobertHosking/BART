class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|

        t.boolean :active #is this dataset avalible for report generation?
        t.string :term
        t.string :year
        t.string :name
        t.integer :permission #what permission level does this dataset have?
        t.string :csv

        t.string :base_path
        t.string :original_file
        t.string :yaml_file
        t.string :working_file
        t.text :columns
        t.text :display_columns
      t.timestamps
    end
  end
end
