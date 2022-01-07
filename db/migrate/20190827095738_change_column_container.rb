class ChangeColumnContainer < ActiveRecord::Migration[5.2]
  def change
    rename_column :containers, :class, :cls
  end
end
