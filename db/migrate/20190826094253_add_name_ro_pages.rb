class AddNameRoPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :name, :string
  end
end
