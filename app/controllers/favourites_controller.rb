class FavouritesController < ApplicationController
  # before_action :set_favourite, only: [:destroy]

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
    @favourite.save!
    # if @favourite.save
    #     redirect_to favourites_path
    # else
    #   flash[:alert] = "didn't save!"
    #   render 'new'
    # end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to favourites_path
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end
end
