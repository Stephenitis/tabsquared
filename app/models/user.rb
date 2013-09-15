class User < ActiveRecord::Base

  def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash["uid"]

    where(uid: uid).first_or_initialize.tap do |user|
      user.uid = uid
      user.oauth_token = auth_hash["credentials"]["token"]
      user.save!
    end
  end

end
