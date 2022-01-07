class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.references      :user       ,foreign_key: true
      t.integer         :phone      ,:null => true
      t.string          :address    ,:null => true
      t.string          :city       ,:null => true
      t.string          :province   ,:null => true
      t.integer         :zipcode    ,:null => true
      t.string          :country    ,:null => true
      t.timestamps
    end
  end
end
