class UsersController < ApplicationController
before_filter :verify_logged_in

  def show
  end

  def edit
  end

  def update
    @user = current_user
    if @user.verified
      @user.update(notifications: params[:user][:notifications])
      flash[:alert] = "update successful"
      render :show
    else
      @user.update(user_params)
      @user.send_verification_code
      render :verify_number
    end
  end

  def verify
    if params[:given_code] == current_user.verification_code
      current_user.update(verified: true)
      redirect_to user_path current_user
    else
      flash[:error] = "Your number did not pass verification..."
      render :verify_number
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :notifications)
  end
end
