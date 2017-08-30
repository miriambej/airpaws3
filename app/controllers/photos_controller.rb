class PhotosController < ApplicationController

  def create
    @room = Room.find(params[:room_id])

    if params[:image]
      params[:images].each do |img|
        @room.photos.create(image: img)
        haha
      end

      @photos = @room.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end
end
