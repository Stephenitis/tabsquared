class RenameJoinTable < ActiveRecord::Migration
  def change
  	rename_table :user_venues, :users_venues
  end
end
