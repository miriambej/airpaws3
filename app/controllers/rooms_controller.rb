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
    @photos = @room.photos #its going to return all the photos that we have for the specific room.
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

  # --- Reservations ---
  def preload
    today = Date.today
    reservations = @room.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }

    render json: output
  end

  private
  #if you get the reservation start date greater than the start date? and the end date of that reservation less than the end date and if the size is greater than zero, that means we can found one reservation inside, then we return true, that means we have a conflict.
  def is_conflict(start_date, end_date, room)
      check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
  end

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
