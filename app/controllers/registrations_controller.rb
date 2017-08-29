class RegistrationsController < Devise::RegistrationsController
  protected
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end

#Here is to say if you want to update your profile without providing the current password
