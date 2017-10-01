class GroupsController < ApplicationController
  before_action :check_group_exists, only: [:create]

  def show
    @group = Group.find(params[:id])

    @event = Event.find(@group.event_id)
    @members = current_user.get_members(@group)

    @messages = []
    @members.each do |member|
      @messages.concat(member.get_messages_in(@event))
    end

    @messages = @messages.sort_by &:created_at
    @messages = @messages.reverse
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
      params.require(:group).permit(:event_id, :user_id)
    end

    def check_group_exists
      if (Group.where(group_params).count != 0)
        redirect_to Group.where(group_params).first
      end
    end
end
