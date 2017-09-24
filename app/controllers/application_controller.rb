class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # I needed to change the default behaviour by overwrite the method after_sign_in_path_for so everytime a user logs in, it will be re-directed to dashboard page.
  def after_sign_in_path_for(resource_or_scope)

  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description])
  end
end
