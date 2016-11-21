class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
        t.integer :page_id
        t.string :title
        t.integer :permission
        t.boolean :visible
        t.string :type
        # enter specific fields for types below
        t.timestamps
    end
  end
end
