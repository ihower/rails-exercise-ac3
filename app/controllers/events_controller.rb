class EventsController < ApplicationController

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.page( params[:page] ).per(5)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events/create
  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "Creating Good Job!"
      redirect_to events_url
    else
      render :action => :new
    end
  end

  # GET /events/show/:id
  def show
    @page_title = @event.name
  end

  # GET /events/edit/:id
  def edit
  end

  # POST /events/create/:id
  def update
    if @event.update_attributes(event_params)
      flash[:notice] = "Editing Good Job!"
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
  end

  # /events/destroy/:id
  def destroy
    @event.destroy

    flash[:alert] = "WTF!"

    redirect_to :action => :index
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description)
  end

end
