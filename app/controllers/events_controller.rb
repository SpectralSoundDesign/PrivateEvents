class EventsController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_login
    return if current_user

    flash[:error] = 'You must be logged in to view this page'
    redirect_to '/'
  end

  def event_params
    params.require(:event).permit(:date)
  end
end
