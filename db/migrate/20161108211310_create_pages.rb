class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
        t.integer :section_id
        t.string :name
        t.integer :permission
        t.boolean :visible
        t.timestamps
    end
  end
end
