class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
    	t.integer :phone_number
      t.integer :uid
    	t.string :oauth_token

      t.timestamps
    end
  end
end
