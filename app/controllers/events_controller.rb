class EventsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_event, only: [:show]

  def index
    # @events = Event.all
    if session[:location]
      if params[:category].present?
        # binding.pry
        find_near_events_type(session[:location], params[:category])
      else
        find_near_events(session[:location])
      end
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
    price_counter
    rand_event(@events)
    # end
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

  # def price_update
  #   @events = []
  #   params[:events].each do |event|
  #     @events << Event.find(event.to_i)
  #   end

  #   if session[:counter].positive?
  #     price_reduction(@events)
  #     session[:counter] -= 1
  #     render :index
  #   else
  #     render :index
  #   end
  # end

  private
  
  def price_counter
    @events.each do |event|
      time = event.start_time - Time.now
      multiple = [0.2, 0.5, 0.8].to_a.sample
        if event.starting_price == event.current_price && time < 1600
          event.current_price = event.starting_price * multiple
          event.price_cents = event.current_price * 100
          event.save
        end
    end
  end


  def rand_event(events)
    if events.empty?
      find_near_events(session[:location])
      # raise
      @rand_event = @events.sample
    else
      @rand_event = events.sample
    end
  end

# events.each do |event|
#       @number = (1..10).to_a.sample
#       multiple = [0.2, 0.5].sample
#       if @number > 5 && event.starting_price > event.min_price
#         event.starting_price = event.starting_price * multiple
#         event.price_cents = event.starting_price * 100
#         event.save

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

  def find_near_events_type(location, category)
    @events = []
    Venue.near(location, 1).each do |venue|
      venue.events.each do |event|
        if event.start_time < (Date.today + 1).midnight && event.start_time > Time.now && event.category == category
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
        id: event.id
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
