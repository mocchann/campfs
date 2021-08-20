module ReviewsHelper
  def reviews_current_number(current_page, size)
    if size > 2
      first = 1
      last  = size
      last *= current_page
      first = last -2
      return "#{first} ~ #{last}"
    else
      return "1 ~ #{size}"
    end
  end
end
