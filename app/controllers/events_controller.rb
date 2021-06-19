class EventsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_event, only: [:show]

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render json: { events: @events } }
    end

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
      @events
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

  def price_update
    @events = []
    params[:events].each do |event|
      @events << Event.find(event.to_i)
    end

    if session[:counter].positive?
      price_reduction(@events)
      session[:counter] -= 1
      render :index
    else
      render :index
    end
  end

  private

  def price_reduction(events)
    events.each do |event|
      # time = event.start_time - Time.now
      number = [1..5].sample
      multiple = [0.2, 0.5, 0.8].to_a.sample
      if number == 3 || 1
        current_price = event.starting_price * multiple
        event.starting_price = current_price
        event.price_cents = current_price * 100
        event.save
      end
    end
  end

  # def price_counter
  #   time = @event.start_time - Time.now
  #   multiple = [0.2, 0.5, 0.8].to_a.sample
  #   if time < 1000
  #     current_price = @event.starting_price * multiple
  #     @event.starting_price = current_price
  #     @event.price_cents = current_price * 100
  #     @event.save
  #   end
  # end

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
        info_window: render_to_string(partial: "info_window", locals: { event: event }),
        image_url: helpers.asset_url('stopwatch.png')
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
