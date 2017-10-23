class MessagesController < ApplicationController
  # Creates a new Message.
  def new
    @message = current_user.messages.new
  end

  # Creates and saves a new Message.
  def create
    @message = current_user.messages.new(message_params)

    if (@message.save)
      flash[:success] = "Message sent!"
    else
      flash[:warning] = "Message could not be sent"
      redirect_to root
    end

    redirect_to request.referrer
  end

  # TODO: implement Message destruction.
  def destroy
  end

  private
    # Get the sanitized paramaters needed to create a Message.
    def message_params
      params.require(:message).permit(:text, :group_id)
    end
end
