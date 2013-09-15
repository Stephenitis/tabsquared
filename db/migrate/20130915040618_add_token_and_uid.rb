class AddTokenAndUid < ActiveRecord::Migration
  def change
  	add_column :users, :uid, :integer
  	add_column :users, :oauth_token, :string
  end
end
