class EventAttendancesController < ApplicationController
  # Create a new EventAttendance.
  def new
    @event_attendance = EventAttendance.new
  end

  # Create and save a new EventAttendance.
  def create
    @event_attendance = current_user.event_attendances.new(event_attendance_params)

    if (@event_attendance.save)
      flash[:success] = "Attending event!"
    else
      flash[:warning] = "Something went wrong"
    end

    redirect_to request.referrer
  end

  private
    # Gets the sanitized parameters needed to create an EventAttendance.
    def event_attendance_params
      params.require(:event_attendance).permit(:event_id)
    end
end
