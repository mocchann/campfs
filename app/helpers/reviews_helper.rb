module ReviewsHelper
  def reviews_current_number(current_page, size)
    if size > 2
      last  = size
      last *= current_page
      first = last - 2
      "#{first} ~ #{last}"
    else
      "1 ~ #{size}"
    end
  end
end
