class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @rooms = Room.all.includes(:user).order("created_at DESC")
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @rooms = Room.all.includes(:user)
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    # binding.pry
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)#, room_id: params[:room_id])
  end
end
