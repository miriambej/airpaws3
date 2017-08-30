class RoomController < ApplicationController
before_action :set_room, except: [:index, :new, :create] #this means before every action, run the set_room first, so we do not need to repeat the code in every def needed
  def index
    @rooms = current_user.rooms #return all the rooms to the current user
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
  end

  def listing

  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  def update
  end

  private
  def set_room
    @room = Room.find(params[:id]) #to go to the specific room
  end

  def room_params
    params.require(:room).permit(:home_type, :accommodate, :listing_name, :summary, :address, :is_toys, :is_treats, :is_food, :is_garden, :is_exercise, :price, :active)
  end
end
