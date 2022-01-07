class RemoveForeignKeyFromPageColumnsAddPageFormForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :page_columns, name: "fk_rails_1a4b30f12b"
    remove_column :page_columns, :page_id, :bigint
    add_reference :page_columns, :page_form, foreign_key: true
  end
end
