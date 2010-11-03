class RecommendationsController < ApplicationController
  def new
    @recommendation = Recommendation.new
  end
  
  def create
    @recommendation = Recommendation.new(params[:recommendation])
    if @recommendation.save
      flash[:notice] = "Successfully created recommendation."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
