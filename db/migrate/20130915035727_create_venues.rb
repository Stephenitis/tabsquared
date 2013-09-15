class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
    	t.integer :venue_id
    end
  end
end
