class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
        t.integer :section_id
        t.string :title
        t.string :level # indiviidual, dept, division, school wide
        t.string :datasets # what datasets does it have access to
        t.integer :permission
        t.boolean :visible
        t.string :type # bar, pie, line, etc
        t.string :columns # [[dataset, column], [dataset, column]] 

        # enter specific fields for types below
        t.timestamps
    end
  end
end
