class CreateRows < ActiveRecord::Migration[5.2]
  def change
    create_table :rows do |t|
      t.references :container, foreign_key: true
      t.string :name
      t.string :class
      t.timestamps
    end
  end
end
