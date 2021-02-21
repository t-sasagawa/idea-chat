class MessagesController < ApplicationController
  def index
    @rooms = Room.all.includes(:user).order("created_at DESC")
  end
end
