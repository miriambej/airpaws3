class ReservationsController < ApplicationController
  before_action :authenticate_user! #you need to authenticate user before booking a room.

  def create
    room = Room.find(params[:room_id]) #we need to find the roon as reservations is nested in rooms.

    if current_user == room.user
      flash[:alert] = "You cannot book your own property!"
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      @reservation = current_user.reservations.build(reservation_params)
      @reservation.room = room
      @reservation.price = room.price
      @reservation.total = room.price * days
      @reservation.save

      flash[:notice] = "Booked Successfully!"
    end
    redirect_to room
  end

  # All reservations belong to current_user, we got the trips
  def your_pet_trips
      @trips = current_user.reservations.order(start_date: :asc)
  end

  #we need to get all the rooms belong to the current_user
  def your_reservations
    @rooms = current_user.rooms
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date) #we do not need to pass user_id and room_id because we are getting them from @reservation.room = room.
  end
end
