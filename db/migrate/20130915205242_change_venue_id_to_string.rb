class ChangeVenueIdToString < ActiveRecord::Migration
  def change
  	remove_column :venues, :venue_id
  	add_column :venues, :venue_id, :string
  end
end
