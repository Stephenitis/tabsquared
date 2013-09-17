class CommandController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def listener		
    checkin = decode_foursquare_push(request)
    p "checkin"
    p checkin
    p "8" *99

		managers = find_managers(checkin)
    p "8" *99

    p managers
		checkin[:phone] = managers.select { |manager| manager.notifications }.map { |manager| manager.phone_number}
    p "8" *99
    p checkin
    send_to_worker(checkin) if checkin[:phone].any?
		render nothing: true
	end

private

  def send_to_worker(checkin)
    HTTParty.post("https://mq-aws-us-east-1.iron.io/1/projects/52342e7c245f5c0009000001/queues/tabsquaredqueue/messages/webhook?oauth=JyzomLPboE13Gni-d7VgfpoMPWw", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
  end

  def find_managers(checkin)
    Venue.find_by(venue_id: checkin['venue']['id']).try(:users)
  end


  def decode_foursquare_push(request)
    JSON.parse(URI.decode_www_form(request.raw_post, enc=Encoding::UTF_8)[0][1])
  end

end