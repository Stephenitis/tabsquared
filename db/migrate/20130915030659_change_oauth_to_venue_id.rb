class ChangeOauthToVenueId < ActiveRecord::Migration
  def change
  	remove_column :users, :oauth_token
  	add_column :users, :venue_id, :integer
  end
end
