class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :page, foreign_key: true
      t.string :name
      t.string :class
      t.timestamps
    end
  end
end
