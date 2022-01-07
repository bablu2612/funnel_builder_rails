class AddScreenshotToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :screenshot, :string
  end
end
