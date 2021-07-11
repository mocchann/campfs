class ReviewsController < ApplicationController
before_action :authenticate_user!

  def new
    @review = Review.new
    @field = Field.find(params[:field_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      # flash[:success] = "口コミを投稿しました。"
      redirect_to field_path(params[:field_id])
    else
      # flash.now[:danger] = "口コミの投稿に失敗しました。"
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to request.referer
  end

  private

    def review_params
      params.require(:review).permit(:title, :content, :rate).merge(field_id: params[:field_id])
    end
end
