class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @favourite = Favourite.new
    @event = Event.find(params[:event_id])
    @favourite.user = current_user
    @favourite.event = @event
    if @favourite.save
        redirect_to favourites_path
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
