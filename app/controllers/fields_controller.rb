class FieldsController < ApplicationController
  def show
    @field = Field.find(params[:id])
    @reviews = Review.includes(:user)
  end

  def search
    @fields = Field.page(params[:page]).per(1)
  end
end
