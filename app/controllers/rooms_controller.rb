class RoomsController < ApplicationController
before_action :set_room, except: [:index, :new, :create] #this means before every action, run the set_room first, so we do not need to repeat the code in every def needed
before_action :authenticate_user!, except: [:show] #if user want to go to index page to update the room they need to log in, except show because you can open a room without authenticate because that is public.
before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update] #if user wants to update a listing that it is not with its id, he/she would not be able to do it.
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
    @photos = @room.photos
  end

  def amenities
  end

  def location
  end

  def update

    new_params = room_params #if room is not ready, you choose the rooms params
    new_params = room_params.merge(active: true) if is_ready_room #if the room is active(ready status),then, you merge the active attribute to the rooms param with the value of true and then you pass the new params into the new params below. 

    if @room.update(new_params)
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

  def is_authorised
    redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
  end

  def is_ready_room
    !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.address.blank?
  end

  def room_params
    params.require(:room).permit(:home_type, :accommodate, :listing_name, :summary, :address, :is_toys, :is_treats, :is_food, :is_garden, :is_exercise, :price, :active)
  end
end
