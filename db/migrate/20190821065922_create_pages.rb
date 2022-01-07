class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.references :funnel, foreign_key: true

      t.timestamps
    end
  end
end
