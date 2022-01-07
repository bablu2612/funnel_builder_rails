class AddUserIdToPreviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :previews, :user, foreign_key: true
  end
end
