class CommandController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def listener		
		checkin = JSON.parse(URI.decode_www_form(request.raw_post, enc=Encoding::UTF_8)[0][1])
		puts "*"*100
		puts "*"*100
		p checkin
		puts "*"*100
		puts "*"*100
		managers = Venue.where(venue_id: checkin['venue']['id']).first
		managers = managers.users
		checkin[:phone] = managers.map { |manager| manager.phone_number }

		HTTParty.post("https://mq-aws-us-east-1.iron.io/1/projects/52342e7c245f5c0009000001/queues/tabsquaredqueue/messages/webhook?oauth=JyzomLPboE13Gni-d7VgfpoMPWw", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
		# response = HTTParty.post("http://requestb.in/13c4d4f1", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
		render nothing: true
	end

	def test
		checkin = JSON.parse(URI.decode_www_form(request.raw_post, enc=Encoding::UTF_8)[0][1])
		puts checkin
		checkin[:phone] = [7039755863, 8082183629]
		HTTParty.post("https://mq-aws-us-east-1.iron.io/1/projects/52342e7c245f5c0009000001/queues/tabsquaredqueue/messages/webhook?oauth=JyzomLPboE13Gni-d7VgfpoMPWw", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
		# response = HTTParty.post("http://requestb.in/13c4d4f1", body: checkin.to_json, options: { :headers => { 'ContentType' => 'application/json' } })
		render nothing: true
	end
end