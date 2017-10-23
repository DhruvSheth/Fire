class InterestsController < ApplicationController
  # Assures a User can only affect his or her interesets.
  before_action :assert_correct_user

  # Creates a new Interest.
  def new
    @interest = current_user.interests.new
  end

  # Creates and saves a new Interest.
  def create
    @interest = current_user.interests.new(interest_params)

    if (@interest.save)
      flash[:success] = "Interest saved!"
    else
      flash[:warning] = "Could not save that interest"
    end

    redirect_to current_user
  end

  # Destroys the event of the given event_id.
  def destroy
    Interest.find(params[:id]).destroy

    redirect_to current_user
  end

  private
    # Gets the sanitized parameters needed to create an Interest.
    def interest_params
      params.require(:interest).permit(:tag)
    end

    # Redirects to the last page if a User trys to change or create any tags
    # for any other User than themselves.
    def assert_correct_user
      unless(is_current_user?(User.find(params[:interest][:user_id])))
        flash[:warning] = "Can only change your own tags"
        redirect_to request.referrer
      end
    end
end
