class SessionsController < ApplicationController

  def new
  end

  def create
    @success = false
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      @success = true
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
