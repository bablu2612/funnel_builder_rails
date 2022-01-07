class RemoveClsNameArrayTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :sections, :cls, :string
    remove_column :sections, :name, :string
    remove_column :containers, :cls, :string
    remove_column :containers, :name, :string
    remove_column :rows, :cls, :string
    remove_column :rows, :name, :string
    remove_column :columns, :cls, :string
    remove_column :columns, :name, :string
  end
end
