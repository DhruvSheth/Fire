class InterestsController < ApplicationController
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
end
