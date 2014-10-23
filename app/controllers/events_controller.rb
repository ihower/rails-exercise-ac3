class EventsController < ApplicationController

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events/create
  def create
    @event = Event.new(event_params)
    @event.save

    redirect_to :action => :index
  end

  # GET /events/show/:id
  def show
    @event = Event.find( params[:id] )
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

end
