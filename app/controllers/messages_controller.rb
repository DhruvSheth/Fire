class MessagesController < ApplicationController
  def new
    @message = current_user.messages.new
  end

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

  def destroy
  end

  private

    def message_params
      params.require(:message).permit(:text, :group_id)
    end
end
