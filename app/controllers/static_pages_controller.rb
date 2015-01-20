class StaticPagesController < ApplicationController

  def home
  end

  def loadNewDay
    respond_to do |format|
      format.js
      format.html 
    end
  end
end
