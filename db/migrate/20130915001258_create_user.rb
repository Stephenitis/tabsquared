class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer :phone_number
    	t.string :oauth_token
    end
  end
end
