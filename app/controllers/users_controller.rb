class UsersController < ApplicationController
  # Sets up all the user info (interests, events) for
  # the Users view to display.
  def show
    @user = User.find(params[:id])
    @interests = @user.interests
    @created_events = @user.events
    @attended_events = @user.attended_events
  end
end
