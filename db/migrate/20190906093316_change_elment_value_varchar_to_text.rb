class ChangeElmentValueVarcharToText < ActiveRecord::Migration[5.2]
  def change
    change_column :page_elements, :value, :text
  end
end
