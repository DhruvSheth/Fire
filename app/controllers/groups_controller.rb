class GroupsController < ApplicationController
  # Before creating a new Group, see if another group with the
  # same User and Event exists.
  before_action :check_group_exists, only: [:create]

  # Gets the necessary information to display a group, including
  # its members and messages.
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

  # Creates a new group.
  def new
    @group = current_user.groups.new
  end

  # Creates and saves a new group, using the paramaters from the
  # Group creation form.
  def create
    @group = current_user.groups.new(group_params)

    if (@group.save)
      flash[:success] = "Found a new group!"
    else
      flash[:warning] = "Could not create group"
    end

    redirect_to @group
  end

  # TODO: implement Group destruction.
  def destroy
  end

  private
    # Gets the sanitized parameters needed to create a new Group.
    def group_params
      params.require(:group).permit(:event_id, :user_id)
    end

    # If the group with the Group parameters already exists, redirect
    # to that existing group.
    def check_group_exists
      if (Group.where(group_params).count != 0)
        redirect_to Group.where(group_params).first
      end
    end
end
