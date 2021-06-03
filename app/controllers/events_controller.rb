class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    if params[:query].present?
      @events = Event.search_events_pg(params[:query])
    else
      @events = Event.all
    end
    @markers = @events.map do |event|
      {
        lat: event.venue.latitude,
        lng: event.venue.longitude
      }
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
