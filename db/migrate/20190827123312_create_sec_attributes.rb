class CreateSecAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :sec_attributes do |t|
      t.references :section, foreign_key: true
      t.references :container, foreign_key: true
      t.references :row, foreign_key: true
      t.references :column, foreign_key: true
      t.string :attri
      t.string :value

      t.timestamps
    end
  end
end
