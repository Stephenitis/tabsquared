require 'foursquare2'
require 'twilio-ruby'
# require 'googl'

@foursquare_client = Foursquare2::Client.new(:client_id => params[:FOURSQUARE_CLIENT_ID], :client_secret => params[:FOURSQUARE_CLIENT_SECRET])

checkin_params = params
@name = params["user"]["firstName"]
@home_city = params["user"]["homeCity"]
@phone_numbers = params["phone"]


##################### SECOND FOURSQUARE API CALL
user_params = @foursquare_client.user(checkin_params["user"]["id"])


@primary_body = "Tab Squared Alert: #{@name} from #{@home_city} just checked in! image: #{@image_url}"
p "The response : #{@primary_body}"
p "The response length should be at #{@primary_body.length}"

########################TWILIO CLIENT

account_sid = params[:TWILIO_SID]
auth_token = params[:TWILIO_TOKEN]
twilio_phone = params[:TWILIO_NUMBER]

@twilio_client = Twilio::REST::Client.new(account_sid, auth_token)

@account = @twilio_client.account
	p "sending a phone messages"

@phone_numbers.each do |phone|
	p "sending a primary message to #{phone}"
@message = @account.sms.messages.create(
  :from => twilio_phone,
  :to => phone,
  :body => @primary_body
)
end

@friend_count = user_params["friends"]["count"]
@badge_count = user_params["badges"]["count"]
@checkin_count = user_params["checkins"]["count"]
@tips_count = user_params["tips"]["count"]
@type = user_params["type"]
@followers = user_params["following"]["count"]

@secondary_body = "#{@name} has #{@friend_count} friends | #{@followers} followers | has logged #{@checkin_count} checkins | has #{@badge_count} badges | tipped on locations #{@tips_count} " 

p "secondary_body = #{@secondary_body}"
p "length #{@secondary_body.length}"


@phone_numbers.each do |phone|
	p "sending a secondary message to #{phone}"
@message = @account.sms.messages.create(
  :from => twilio_phone,
  :to => phone,
  :body => @secondary_body
)
end

#### TO DO

##### if user tip count > 10 send a HIGH TIPSTER ALERT

##### if user followers is > 50 send a social celebrity alert or friends > 100

##### if user type is != "user" send a super user alert

##### if user badge count > 50 possibly a sticker.


