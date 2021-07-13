class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :login_user, except: [:profile_update]

  def show
    @user = User.find(params[:id])
    @fields = @user.bookmark_fields.includes(:reviews)
    @fields = Field.page(params[:page]).per(1)
  end

  def profile
  end

  def profile_update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to users_profile_path, notice: "プロフィールを更新しました"
    else
      render :profile
    end
  end


  private

  # def login_user
  #   @user = User.find(current_user.id)
  # end

  def user_params
    params.require(:user).permit(:new_icon_img, :name, :email, :description, :password)
  end
end
