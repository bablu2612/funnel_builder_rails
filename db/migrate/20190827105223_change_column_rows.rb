class ChangeColumnRows < ActiveRecord::Migration[5.2]
  def change
    rename_column :columns, :class, :cls
  end
end
