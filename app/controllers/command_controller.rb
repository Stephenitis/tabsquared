class CommandController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def listener		
		checkin = JSON.parse(URI.decode_www_form(request.raw_post, enc=Encoding::UTF_8)[0][1])
		managers = Venue.where(venue_id: checkin['venue']['id']).first
		managers = managers.users
		checkin[:phone] = managers.map { |manager| manager.phone_number }
		HTTParty.post("https://mq-aws-us-east-1.iron.io/1/projects/52342e7c245f5c0009000001/queues/tabsquaredqueue/messages/webhook?oauth=JyzomLPboE13Gni-d7VgfpoMPWw", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
		render nothing: true
	end

end