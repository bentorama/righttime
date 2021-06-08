class FavouritesController < ApplicationController
  before_action :set_favourite, only: [:show]

  def show
  end

  def new
    @event = Event.find(params[:event_id])
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new
    @event = Event.find(params[:event_id])
    @favourite.user = current_user
    @favourite.event = @event
    if @favourite.save
        redirect_to(@favourite)
    else
      flash[:alert] = "didn't save!"
      render 'new'
    end
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end
end
