class AddBackgroundToPagesAndPreviews < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :background, :string
    add_column :previews, :background, :string
  end
end
