class RoomsController < ApplicationController

  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # @rooms = Room.new
    @rooms = Room.all.includes(:user).order("created_at DESC")
  end

  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    # binding.pry
    if @room.valid? 
       @room.save
       redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  private

  # def set_room
  #   @room = Room.find(params[:id])
  # end

  def room_params
    params.require(:room).permit(:name).merge(user_id: current_user.id)
  end
end