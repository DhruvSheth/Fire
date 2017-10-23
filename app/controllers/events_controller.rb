class EventsController < ApplicationController
  # Creates a new Event.
  def new
    @event = Event.new
  end

  # Creates and saves a new Event based on the paramaters sent
  # from the Event creation form.
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

  # Gets the Event to show for the Events view.
  def show
    @event = Event.find(params[:id])
  end

  # Gets all the Events, paginated for easy viewing.
  def index
    @events = Event.paginate(page: params[:page], per_page: 10)
  end

  private
    # The sanitized parameters an Event needs to be created.
    def event_params
      params.require(:event).permit(:title, :location, :start_time, :end_time, :description, :picture_url)
    end
end
