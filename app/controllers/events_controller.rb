class EventsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_event, only: [:show]

  def index
    if params[:query].present? && params[:query] != "" 
      location = params[:query]
      find_near_events(location)
    elsif params[:hidden].present? && params[:hidden] != "" 
      location = params[:hidden]
      find_near_events(location)
    else
      @events = Event.all
    end
    markers_and_center
  end

  def show; end

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

  def find_near_events(location)
    @events = []
    Venue.near(location, 1).each do |venue|
      venue.events.each do |event|
        if event.start_time < (Date.today + 1).midnight && event.start_time > Time.now
          @events << event
        end
      end
    end
  end

  def markers_and_center
    @markers = @events.map do |event|
      {
        lat: event.venue.latitude,
        lng: event.venue.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
    if params[:query] == "" || params[:query].nil?
      @center = nil
    else
      @center = {
        lat: Geocoder.search(params[:query]).first.coordinates[0],
        lng: Geocoder.search(params[:query]).first.coordinates[1]
      }
    end
  end
end
