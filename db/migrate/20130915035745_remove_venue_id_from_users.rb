class RemoveVenueIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :venue_id
  end
end
