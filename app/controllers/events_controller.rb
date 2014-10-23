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

    @page_title = @event.name
  end

  # GET /events/edit/:id
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events/create/:id
  def update
    @event = Event.find(params[:id])
    @event.update_attributes(event_params)

    redirect_to :action => :show, :id => @event
  end

  # /events/destroy/:id
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

end
