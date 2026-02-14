module FieldsHelper
  def rating(reviews)
    normalized_reviews = Array(reviews).compact
    return 0.0 if normalized_reviews.empty?

    rate_sum = normalized_reviews.sum do |review|
      review.respond_to?(:rate) ? review.rate.to_f : review.to_f
    end
    (rate_sum / normalized_reviews.count).round(2)
  end

  def fields_current_number(current_page, size)
    current_page = current_page.to_i
    size = size.to_i

    if size > 8
      last = size * current_page
      first = last - 8
      "#{first} ~ #{last}"
    else
      "1 ~ #{size}"
    end
  end
end
