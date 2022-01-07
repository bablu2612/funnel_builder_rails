class CreateElementStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :element_styles do |t|
      t.references :page_element, foreign_key: true
      t.string :style , :null => true
      t.string :value , :null => true
      t.timestamps
    end
  end
end
