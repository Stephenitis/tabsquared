class CommandController < ApplicationController
	def listener
		user = User.find_by_venue_id(params[:venue[:id]]) 
		params[:phone] = user.phone_number
	end
end