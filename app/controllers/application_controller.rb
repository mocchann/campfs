class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:/] #あとでコントローラーに移す？
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :email, :icon_img])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end
end
