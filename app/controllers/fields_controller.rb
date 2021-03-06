class FieldsController < ApplicationController
  def show
    @field = Field.find(params[:id])
    @reviews = @field.reviews.includes(:user).page(params[:page])
  end

  def search
    @fields = @q.result.page(params[:page])
  end
end
