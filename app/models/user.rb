class User < ActiveRecord::Base
  has_and_belongs_to_many :venues
  
  def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash["uid"]
    where(uid: uid).first_or_initialize.tap do |user|
      user.uid = auth_hash["uid"]
      user.first_name = auth_hash["info"]["first_name"]
      user.last_name = auth_hash["info"]["last_name"]
      user.oauth_token = auth_hash["credentials"]["token"]
      client = Foursquare2::Client.new(:oauth_token => user.oauth_token)
      client.managed_venues['items'].each do |venue| 
        user.venues << Venue.first_or_create(venue_id: venue.id)
      end
      user.save!
    end
  end

end
