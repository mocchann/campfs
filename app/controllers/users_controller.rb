class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @fields = @user.bookmark_fields.includes(:reviews).page(params[:page])
  end

  def profile
  end

  def profile_update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to users_profile_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = "プロフィールを更新できませんでした"
      render :profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:new_icon_img, :name, :email, :password)
  end
end
