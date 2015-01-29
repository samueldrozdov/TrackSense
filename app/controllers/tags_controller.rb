class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    @submissions = @tag.submissions
  end
end
