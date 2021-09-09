module FieldsHelper
  def rating(reviews)
    rate = 0.0
    if reviews.any?
      reviews.each { |review| rate += review.rate.to_f }
      rate /= reviews.count
    end
    rate.round(2)
  end

  def fields_current_number(current_page, size)
    if size > 8
      first = 1
      last  = size
      last *= current_page
      first = last -8
      "#{first} ~ #{last}"
    else
      "1 ~ #{size}"
    end
  end
end
