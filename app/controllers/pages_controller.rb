class PagesController < ApplicationController
  def home
    @rooms = Room.where(active: true).limit(3)
  end

  def search
    #STEP 1: we need to check wether the user provided location or not. The session[:loc_search] is to remember the location that people search for, so for the next search they dont have to re-type the location again, unless they want to search for a different location.
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    #STEP 2: If we have a value for the location and then we are going to get all the room within or nearby the specific location, we are going to display all the rooms within 5km, else we will get all the rooms active in the database.
    if session[:loc_search] && session[:loc_search] != ""
      @rooms_address = Room.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @rooms_address = Room.where(active: true).all
    end

    #STEP 3: once we have all the rooms that we need in step 2, we are going to apply all the filters that user selected, this is ransack job.
    @search = @rooms_address.ransack(params[:q])
    @rooms = @search.result

    @arrRooms = @rooms.to_a

    #STEP 4: if user search for the date range, we will look for the conflict ones that are booked and delete them from the array, so they dont show on the result.
    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? &&  !params[:end_date].empty?)
      #here I converted the params start_date into a date object and assigned to the start_date and end_date variable
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @rooms.each do |room|

        not_available = room.reservations.where(
          "(? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)

        if not_available.length > 0
        @arrRooms.delete(room)
        end
      end
    end

  end
end
