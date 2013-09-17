class User < ActiveRecord::Base
  has_and_belongs_to_many :venues

  after_create :find_venues
  
  def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash["uid"]
    where(uid: uid).first_or_initialize.tap do |user|
      user.uid = auth_hash["uid"]
      user.first_name = auth_hash["info"]["first_name"]
      user.last_name = auth_hash["info"]["last_name"]
      user.oauth_token = auth_hash["credentials"]["token"]
      user.save!
    end
  end

  def send_verification_code
    self.update(verification_code: (1000 + rand(8999)).to_s)
    twilio_client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    twilio_client.account.sms.messages.create(
      body: "TabSquared Verification Number is #{self.verification_code}",
      to: "+1#{self.phone_number}",
      from: "#{ENV["TWILIO_NUMBER"]}")
  end

  def find_venues
    client = Foursquare2::Client.new(:oauth_token => self.oauth_token)
    client.managed_venues['items'].each do |venue| 
      self.venues << Venue.first_or_create(venue_id: venue.id)
    end
  end
end
