class FieldsController < ApplicationController
  def show
    @field = Field.find(params[:id])
    @reviews = @field.reviews.includes(:user)
  end

  def search
    @fields = @q.result
    @fields_search = @fields.page(params[:page]).per(9)
  end
end
