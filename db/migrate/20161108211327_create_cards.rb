class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
        t.integer :section_id
        t.string :title
        t.string :level # indiviidual, dept, division, school wide
        t.string :chart_type # bar, pie, line, etc
        t.integer :dataset_id # additional datasets
        t.string :column # Column name
        t.string :where_column
        t.string :where_equals
        t.string :action
        t.text :text
        t.integer :order
        # enter specific fields for types below
        t.timestamps
    end
  end
end
