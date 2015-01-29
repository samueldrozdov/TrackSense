class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    if @tag
      @submissions = @tag.submissions
    end
  end
end
