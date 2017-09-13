class GuestReviewsController < ApplicationController
# copied from HostReviewsController and modified

  def create
    #Check if reservation exist (room_id, host_id, host_id)

    #Check if the current host already reviewed the guest in this reservation.

    @reservation = Reservation.where(
                    id: guest_review_params[:reservation_id],
                    room_id: guest_review_params[:room_id],
                    ).first

    if !@reservation.nil? && @reservation.room.user.id == guest_review_params[:host_id].to_i
      @has_reviewed = GuestReview.where(
                        reservation_id: @reservation.id,
                        host_id: guest_review_params[:host_id]
                        ).first
      if @has_reviewed.nil?
        # Allow to review, in this instance, current_user is the host_id
        @guest_review = current_user.guest_reviews.create(guest_review_params)
        flash[:success] = "Review created..."
      else
        # Already reviewed
        flash[:success] = "You already reviewed this Reservation"

      end

    else
      flash[:alert] = "Not found this reservation"
    end

      #after we create a host review, we redirect them back to the current page
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @guest_review = Review.find(params[:id])
    @guest_review.destroy
    redirect_back(fallback_location: request.referer, notice: "Removed...!")
  end



  private
  #we need host_id as they are the ones reviewing the host.
    def guest_review_params
      params.require(:guest_review).permit(:comment, :star, :room_id, :reservation_id, :host_id)
    end
end
