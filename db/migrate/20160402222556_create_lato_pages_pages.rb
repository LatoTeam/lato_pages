class CreateLatoPagesPages < ActiveRecord::Migration
  def change
    create_table :lato_pages_pages do |t|
      t.string :name
      t.string :title
      t.integer :position
      t.string :superpage_name
      t.datetime :last_edit
      t.boolean :visible, default: true
    end
  end
end
