class CreateSections < ActiveRecord::Migration[5.0]

 def change
    create_table :sections do |t|
        t.string :name
        t.integer :report_id
        t.text :layout
        t.timestamps
    end
  end
end
