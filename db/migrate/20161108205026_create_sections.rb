class CreateSections < ActiveRecord::Migration[5.0]
 
 def change
    create_table :sections do |t|
        t.integer :dataset_id    
        t.string :name
        t.integer :access
        t.boolean :visible
        t.timestamps
    end
  end
end
