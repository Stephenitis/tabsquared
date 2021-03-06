class CommandController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def listener		
    checkin = decode_foursquare_push(request)
		managers = find_managers(checkin)
		checkin[:phone] = managers.select { |manager| manager.notifications && manager.verified }.map { |manager| manager.phone_number}
    checkin[:TWILIO_SID] = ENV["TWILIO_SID"]
    checkin[:TWILIO_TOKEN] = ENV["TWILIO_TOKEN"]
    checkin[:TWILIO_NUMBER] = ENV["TWILIO_NUMBER"]
    checkin[:FOURSQUARE_CLIENT_ID] = ENV["FOURSQUARE_CLIENT_ID"]
    checkin[:FOURSQUARE_CLIENT_SECRET] = ENV["FOURSQUARE_CLIENT_SECRET"]
    send_to_worker(checkin) if checkin[:phone].any?
		render nothing: true
	end

private

  def send_to_worker(checkin)
    HTTParty.post(ENV["WORKER_WEBHOOK_URL"], body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
  end

  def find_managers(checkin)
    Venue.find_by(venue_id: checkin['venue']['id']).try(:users)
  end


  def decode_foursquare_push(request)
    JSON.parse(URI.decode_www_form(request.raw_post, enc=Encoding::UTF_8)[0][1])
  end

end