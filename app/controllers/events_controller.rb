class EventsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_event, only: [:show]

  def index
    if session[:location]
      find_near_events(session[:location])
    elsif params[:query].present? && params[:query] != ""
      location = params[:query]
      session[:location] = location
      find_near_events(location)
    elsif params[:hidden].present? && params[:hidden] != ""
      location = params[:hidden]
      session[:location] = location
      find_near_events(location)
    else
      @events = Event.all
    end
    markers_and_center
    rand_event(@events)
    price_counter(Event.all)

    
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

  def price_counter(events)
    events.each do |event|
      time = event.start_time - Time.now
      multiple = [0.2, 0.5, 0.8].to_a.sample
      if event.current_price == event.starting_price && time < 16200
        event.current_price = event.starting_price * multiple
        event.price_cents = event.current_price * 100
        event.save
      end
    end
  end

  def rand_event(events)
    @rand_event = events.sample
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def find_near_events(location)
    @events = []
    Venue.near(location, 1).each do |venue|
      venue.events.each do |event|
        if event.start_time.hour > Time.now.hour
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
        info_window: render_to_string(partial: "info_window", locals: { event: event }),
        image_url: helpers.asset_url('stopwatch.png'),
        id: event.id,
        category: event.category
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
