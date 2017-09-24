class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms
    #Display all the guest reviews to host (if this user is a host)
    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)

    #Display all the host reviews to host (if this user is a guest)
    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
  end

  # once you click on edit profile and if you update or create a new phone number, is going to update that phone number and pin, and then is going to run the generate pin, and then we send the pin to the user mobile number.
  def update_phone_number
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: "Saved..."
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  def verify_phone_number
    current_user.verify_pin(params[:user][:pin])

    if current_user.phone_verified
      flash[:notice] = "Your phone number is verified."
    else
      flash[:alert] = "Cannot verify your phone number."
    end

    redirect_to edit_user_registration_path
    # if there is something wrong, we are going to redirect to the edit profile page.
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  private

    def user_params
      params.require(:user).permit(:phone_number, :pin)
    end
end
