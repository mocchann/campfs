class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:/]
  before_action :set_q
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user, except: [:profile_update]

  def after_sign_in_path_for(resource)
    root_path
  end

  def set_user
    if current_user.present?
      @user = User.find(current_user.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :icon_img])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  private

  def set_q
    @q = Field.ransack(params[:q])
  end
end
