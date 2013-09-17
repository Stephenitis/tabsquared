class WelcomeController < ApplicationController
	skip_before_filter :verify_logged_in
	before_filter :check_logged_in
  def index
  end
  def check_logged_in
  	redirect_to (current_user) if current_user
  end
end
