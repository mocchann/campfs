class HomeController < ApplicationController
  def top
  end

  # ゲストユーザーログイン
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |gest|
      gest.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーさん、こんにちは！'
  end
end
