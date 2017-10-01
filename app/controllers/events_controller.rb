class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

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
    @events = Event.paginate(page: params[:page], per_page: 10)
  end

  private

    def event_params
      params.require(:event).permit(:title, :location, :start_time, :end_time, :description, :picture_url)
    end
end
