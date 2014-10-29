class Admin::EventsController < ApplicationController

  before_action :authenticate_user!

  before_action :authenticate_admin

  layout "admin"

  def index
    @events = Event.all
  end

  def create

    redirect_to admin_events_path
  end

  protected

  def authenticate_admin
    unless current_user.is_admin
      flash[:alert] = "Not allow!"
      redirect_to events_path
    end
  end

end
