class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
    @user = current_user
    verification_code = (1000 + rand(8999)).to_s
    params[:user][:verification_code] = verification_code
    current_user.update(user_params)
    twilio_client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    twilio_client.account.sms.messages.create(
      body: "Hello from TabSquared! Your verification code is #{verification_code}",
      to: "+1#{current_user.phone_number}",
      from: "#{ENV["TWILIO_NUMBER"]}")
    render :verify_number
  end

  def verify
    if params[:given_code] == current_user.verification_code
      redirect_to user_path current_user
    else
      flash[:error] = "Your number did not pass verification..."
      render :verify_number
    end

  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :verification_code)
  end
end
