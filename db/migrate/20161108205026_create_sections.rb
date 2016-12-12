class CreateSections < ActiveRecord::Migration[5.0]

 def change
    create_table :sections do |t|
        t.belongs_to :report, index: true
        t.string :name

        t.timestamps
    end
  end
end
