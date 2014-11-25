class EventsController < ApplicationController

  before_action :set_event, :only => [ :dashboard, :show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /events
  def index
    if params[:keyword]
      @events = current_user.events.where( [ "name like ?", "%#{params[:keyword]}%" ]).page( params[:page] ).per(5)
    elsif params[:order] == "created_at"
      @events = current_user.events.order("created_at DESC").page( params[:page] ).per(5)
    else
      @events = current_user.events.page( params[:page] ).per(5)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.setup_uid
  end

  # POST /events/create
  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      flash[:notice] = "Creating Good Job!"
      redirect_to events_url
    else
      render :action => :new
    end
  end

  # GET /events/show/:id
  def show

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name, description: @event.description }.to_json, :callback => params[:callback] }
      format.js
    end

  end

  def dashboard

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
    @event = Event.find_by_uid(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :category_id, :logo, :_destroy_logo, :uid, :group_ids => [] )
  end

end
