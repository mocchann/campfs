module FieldsHelper
  def rating(reviews)
    rate = 0.0
    if reviews.any?
      reviews.each { |review| rate += review.rate.to_f }
      rate /= reviews.count
    end
    return rate.round(2)
  end
end
