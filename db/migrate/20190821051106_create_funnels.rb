class CreateFunnels < ActiveRecord::Migration[5.2]
  def change
    create_table :funnels do |t|
      t.references :user, foreign_key: true
      t.string :name ,:null => true
      t.timestamps
    end
  end
end
