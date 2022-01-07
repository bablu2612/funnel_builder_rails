class CreateElementAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :element_attributes do |t|
      t.references :page_element, foreign_key: true
      t.string :attribute_name ,:null => true
      t.string :attribute_value ,:null => true
      t.timestamps
    end
  end
end
