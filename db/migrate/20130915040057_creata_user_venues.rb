class CreataUserVenues < ActiveRecord::Migration
  def change
  	create_table :user_venues do |t|
  		t.references :user
  		t.references :venue
  	end
  end
end
