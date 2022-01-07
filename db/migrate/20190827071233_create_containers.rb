class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.references :section, foreign_key: true
      t.string :name
      t.string :class
      t.timestamps
    end
  end
end
