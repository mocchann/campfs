class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]
  before_action :ensure_review_owner, only: [:destroy]

  def new
    @review = Review.new
    @field = Field.find(params[:field_id])
  end

  def create
    @field = Field.find(params[:field_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "口コミを投稿しました。"
      redirect_to field_path(@field)
    else
      flash.now[:danger] = "口コミの投稿に失敗しました。空欄を埋めて下さい。"
      render :new
    end
  end

  def destroy
    @review.destroy
    flash[:alert] = "口コミを削除しました。"
    redirect_to(request.referer || field_path(@review.field_id))
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def ensure_review_owner
    return if @review.user_id == current_user.id

    flash[:alert] = "権限がありません。"
    redirect_to field_path(@review.field_id)
  end

  def review_params
    params.require(:review).permit(:title, :content, :rate).merge(field_id: params[:field_id])
  end
end
