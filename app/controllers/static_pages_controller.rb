class StaticPagesController < ApplicationController

  def home
    @submissions = Track.limit(10).order(priority: :desc)
  end

  def about
  end

  def coming_soon
  end

  def loadNewDay
    @day = params[:day].to_i
    respond_to do |format|
      format.js
      format.html
    end
  end
end
