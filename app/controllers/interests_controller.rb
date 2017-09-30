class InterestsController < ApplicationController
  before_action :assert_correct_user

  def new
    @interest = current_user.interests.new
  end

  def create
    @interest = current_user.interests.new(interest_params)

    if (@interest.save)
      flash[:success] = "Interest saved!"
    else
      flash[:warning] = "Could not save that interest"
    end

    redirect_to current_user
  end

  def destroy
    Interest.find(params[:id]).destroy

    redirect_to current_user
  end

  private

    def interest_params
      params.require(:interest).permit(:tag)
    end

    def assert_correct_user
      unless(is_current_user?(User.find(params[:interest][:user_id])))
        flash[:warning] = "Can only change your own tags"
        redirect_to request.referrer
      end
    end
end
