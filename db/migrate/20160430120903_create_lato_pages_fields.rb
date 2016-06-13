class CreateLatoPagesFields < ActiveRecord::Migration
  def change
    create_table :lato_pages_fields do |t|
      t.string :name
      t.string :title
      t.string :typology
      t.integer :page_id
      t.text :value
      t.text :metadata
      t.string :language
      t.integer :position
      t.string :width
      t.boolean :visible, default: true
    end
  end
end
