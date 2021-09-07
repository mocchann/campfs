class HomeController < ApplicationController
# before_action :set_field
# before_action :set_reviews

  def top
    # @field = Field.new
    # @fields = @field_rank.find(Review.group(:field_id).order('count(rate) desc').limit(3).pluck(:field_id))
  end

  # def set_field
  #   @field = Field.all.includes(:reviews)
  # end

  # def set_reviews
  #   @field_rank = @field.includes(:reviews)
  # end
end
