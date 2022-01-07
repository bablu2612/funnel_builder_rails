class CreatePageElements < ActiveRecord::Migration[5.2]
  def change
    create_table :page_elements do |t|
      t.references :page, foreign_key: true
      t.string :field ,:null => true
      t.string :field_name ,:null => true
      t.string :field_type ,:null => true
      t.string :value ,:null => true
      t.string :width ,:null => true
      t.string :height,:null => true
      t.timestamps
    end
  end
end
