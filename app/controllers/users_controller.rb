class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @fields = @user.bookmark_fields.includes(:reviews).page(params[:page])
  end

  def profile
  end

  def profile_update
    if current_user.email != 'guest@example.com'
      @user = User.find_by(id: params[:id])
      if @user.update(user_params)
        redirect_to users_profile_path, notice: "プロフィールを更新しました"
      else
        flash.now[:alert] = "プロフィールを更新できませんでした"
        render :profile
      end
    else
      redirect_to root_path, alert: 'ゲストユーザーさんは、データの編集・削除などができない設定になっています。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:new_icon_img, :name, :email, :password)
  end
end
