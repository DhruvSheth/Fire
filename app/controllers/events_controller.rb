class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if (@event.save)
      flash[:success] = "Event successfully created!"
      redirect_to @event
    else
      flash[:danger] = "Invalid event"
      redirect_to new_event_path
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

  private

    def event_params
      params.require(:event).permit(:title, :location, :start_time, :end_time, :description)
    end
end