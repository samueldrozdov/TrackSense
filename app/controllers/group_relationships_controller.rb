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
    group = GroupRelationship.find(params[:id]).group
    current_user.leave(group)
    @group = Group.find(group.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
