class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    if params[:query].present?
      # @events = Event.search_events_pg(params[:query])
      find_near_events
    else
      @events = Event.all
    end
    markers_and_center
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

  def find_near_events
    @events = []
    Venue.near(params[:query], 2).each do |venue|
      venue.events.each do |event|
        @events << event
      end
    end
  end

  def markers_and_center
    @markers = @events.map do |event|
      {
        lat: event.venue.latitude,
        lng: event.venue.longitude
      }
    end
    if params[:query].nil?
      @center = nil
    else
      @center = {
        lat: Geocoder.search(params[:query]).first.coordinates[0],
        lng: Geocoder.search(params[:query]).first.coordinates[1]
      }
    end
  end
end
