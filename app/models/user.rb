class User < ActiveRecord::Base

  def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash["uid"]

    where(uid: uid).first_or_initialize.tap do |user|
      user.uid = uid
      user.first_name = auth_hash["info"]["first_name"]
      user.last_name = auth_hash["info"]["last_name"]
      user.oauth_token = auth_hash["credentials"]["token"]
      user.save!
    end
  end

end
