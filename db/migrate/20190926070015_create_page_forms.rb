class CreatePageForms < ActiveRecord::Migration[5.2]
  def change
    create_table :page_forms do |t|
      t.references :page, foreign_key: true

      t.timestamps
    end
  end
end
