class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    @events = Event.all
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
