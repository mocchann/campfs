module ApplicationHelper
  BASE_TITLE = "TO_CAMP".freeze
  
  def full_title(page_title = '')
    if page_title.empty?
      BASE_TITLE
    else
      page_title + ' △ ' + BASE_TITLE
    end
  end

  def default_meta_tags
    {
      title: "TO_CAMP △ キャンプ場を好みの条件で検索できるWebサービス",
      description: "TO_CAMPは、キャンプ場の検索、口コミの投稿・閲覧、気になるキャンプ場の保存ができる、キャンプ好きによるキャンプ好きのためのWebサービスです。",
      icon: [
        { href: image_url('favicon.ico' )},
        { href: image_url('to-camp-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      keywords: 'キャンプ,トゥーキャンプ,TO_CAMP,to_camp,to-camp',
      noindex: ! Rails.env.production?, 
      charset: "UTF-8",
      viewport: "width=device-width, initial-scale=1",

      og: {
        site_name: "TO_CAMP",
        title: "TO_CAMP △ キャンプ場を好みの条件で検索できるWebサービス",
        type: "website",
        url: request.original_url,
        description: "TO_CAMPは、キャンプ場の検索、口コミの投稿・閲覧、気になるキャンプ場の保存ができる、キャンプ好きによるキャンプ好きのためのWebサービスです。",
        image: image_url('top-img.png'),#TODO:あとでイメージを設定して、SNSカードの画像を変更
        locale: "ja_JP",
      },
      twitter: {
        card: "summary",
        site: "@freebblog"
      }
    }
  end
end
