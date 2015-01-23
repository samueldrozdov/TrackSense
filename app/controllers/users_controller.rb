class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @success = false
    @user = User.new(user_params)
    @user.is_admin = false
    if @user.save
      @success = true
      log_in @user
      flash[:success] = "Welcome to Track Sense!"
    end

    respond_to do |format|
      format.html
      format.js
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
    @show_likes = params[:show_likes]
    @show_posts = params[:show_posts]
    likes = @user.voted_submissions
    posts = @user.submissions
    if (@show_likes && @show_posts)
      @submissions = posts - likes + likes
    elsif @show_likes
      @submissions = likes
    elsif @show_posts
      @submissions = posts
    elsif (@show_likes == nil || @show_posts == nil)
      @submissions = posts - likes + likes
    else
      @submissions = nil
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def feed
    @feed = Submission.find
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    

end
