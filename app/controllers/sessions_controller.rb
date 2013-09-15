class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id

    puts "**********UID: #{auth_hash["uid"]}"
    puts "**********token: #{auth_hash["credentials"]["token"]}"

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
