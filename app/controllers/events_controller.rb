class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    if params[:query].present?
      @events = Event.search_events_pg(params[:query])
    else
      @events = Event.all
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json { render json: { event: @event } }
    end
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
