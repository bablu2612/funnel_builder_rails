class CreateStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :styles do |t|
      t.references :section, foreign_key: true
      t.references :container, foreign_key: true
      t.references :row, foreign_key: true
      t.references :column, foreign_key: true
      t.string :style
      t.string :value

      t.timestamps
    end
  end
end
