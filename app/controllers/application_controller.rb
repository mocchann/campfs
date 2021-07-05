class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:/]
  before_action :set_q
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def set_q
    @q = Field.ransack(params[:q]) #この@qにも同じ情報がはいる？
    @results = @q.result #@qには１つの？キャンプ場のカラム情報すべてが入る
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :icon_img])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
