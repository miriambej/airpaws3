class RoomsController < ApplicationController
before_action :set_room, except: [:index, :new, :create] #this means before every action, run the set_room first, so we do not need to repeat the code in every def needed
before_action :authenticate_user!, except: [:show] #if user want to go to index page to update the room they need to log in, except show because you can open a room without authenticate because that is public.
  def index
    @rooms = current_user.rooms #return all the rooms to the current user
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params) #allow the user to create those parameters
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved.." #notice is a flash message will it show saved.
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end

  def show
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
    if @room.update(room_params)
      flash[:notice] = "Saved..." #this means if the user saved succesfully any of the pricing, description, etc, it will show it was saved.
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer) #we redirect them to the current place they were.
  end

  private
  def set_room
    @room = Room.find(params[:id]) #to go to the specific room
  end

  def room_params
    params.require(:room).permit(:home_type, :accommodate, :listing_name, :summary, :address, :is_toys, :is_treats, :is_food, :is_garden, :is_exercise, :price, :active)
  end
end
