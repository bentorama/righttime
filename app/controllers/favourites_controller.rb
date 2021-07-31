class FavouritesController < ApplicationController
  # before_action :set_favourite, only: [:destroy]

  def index
    @favourites = Favourite.all
    @favourites = policy_scope(Favourite)
  end

  def new
    @event = Event.find(params[:event_id])
    authorize @favourite
  end

  def create
    @event = Event.find(params[:event_id])
    existing_favourite = Favourite.find_by(user_id: current_user.id, event_id: @event.id)
    return false if existing_favourite
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.event = @event
    @favourite.save!
    # if @favourite.save
    #     redirect_to favourites_path
    # else
    #   flash[:alert] = "didn't save!"
    #   render 'new'
    # end
    authorize @favourite
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to events_path
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
    
  end
end
