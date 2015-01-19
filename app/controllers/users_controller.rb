class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_admin = false
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Track Sense!"
      redirect_to @user
    else
      flash[:danger] = "Invalid signup"
      redirect_to root_url
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render edit
    end
  end

  def show
    @user = User.find(params[:id])
    # add query for user's posts and likes later
  end

  def feed
      @feed = Submission.find
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
      :password_confirmation)
    end

    

end
