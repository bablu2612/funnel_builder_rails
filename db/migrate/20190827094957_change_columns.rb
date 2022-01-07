class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :sections, :class, :cls
    rename_column :rows, :class, :cls
  end
end
