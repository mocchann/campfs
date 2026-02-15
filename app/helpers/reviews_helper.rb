module ReviewsHelper
  def reviews_current_number(current_page, size)
    current_page = current_page.to_i
    size = size.to_i

    if size > 2
      last = size * current_page
      first = last - 2
      "#{first} ~ #{last}"
    else
      "1 ~ #{size}"
    end
  end
end
