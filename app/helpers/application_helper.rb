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

  def default_meta_tags
    {
      description: "TO_CAMPは、キャンプ場の検索、口コミの投稿・閲覧、気になるキャンプ場の保存ができる、キャンプ好きによるキャンプ好きのためのWebサービスです。",
      icon: image_url("favicon.ico"),
      noindex: ! Rails.env.production?, 
      charset: "UTF-8",
      viewport: "width=device-width, initial-scale=1",

      og: {
        title: "TO_CAMP △ キャンプ好きがキャンプ好きのために作った、キャンプ場を便利に検索できるWebサービス",
        type: "website",
        url: request.original_url,
        site_name: "TO_CAMP",
        description: "TO_CAMPは、キャンプ場の検索、口コミの投稿・閲覧、気になるキャンプ場の保存ができる、キャンプ好きによるキャンプ好きのためのWebサービスです。",
        locale: "ja_JP"
      } 
    }
  end
end
