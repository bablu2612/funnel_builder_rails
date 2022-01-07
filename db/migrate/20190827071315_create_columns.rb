class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.references :row, foreign_key: true
      t.string :name
      t.string :class
      t.timestamps
    end
  end
end
