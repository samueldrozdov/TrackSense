class GroupRelationshipsController < ApplicationController

  #before_action :logged_in_user

  def create
    @group = Group.find(params[:group_id])

    current_user.join(@group)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    membership = GroupRelationship.find(params[:group_id]).followed
    current_user.leave(membership)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
