class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])

    @event = Event.find(@group.event_id)
    @members = current_user.get_members(@group)
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if (@group.save)
      flash[:success] = "Found a new group!"
    else
      flash[:warning] = "Could not create group"
    end

    redirect_to @group
  end

  def destroy
  end

  private

    def group_params
      params.require(:group).permit(:event_id)
    end
end
