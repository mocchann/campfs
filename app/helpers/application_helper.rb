module ApplicationHelper
  BASE_TITLE = "TO_CAMP".freeze
  
  def full_title(page_title = '')
    if page_title.empty?
      BASE_TITLE
    else
      page_title + ' △ ' + BASE_TITLE
    end
  end

  def show_current_number(current_page, size)
    if size > 8
      first = 1
      last  = size
      last *= current_page
      first = last -8
      return "#{first} ~ #{last}"
    else
      return "1 ~ #{size}"
    end
  end
end
