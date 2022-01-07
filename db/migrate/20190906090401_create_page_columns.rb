class CreatePageColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :page_columns do |t|
      t.references :page, foreign_key: true
      t.text :column_name
      t.text :column_value
      t.timestamps
    end
  end
end
