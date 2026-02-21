require 'rails_helper'

RSpec.describe 'fields', type: :system, js: true do
  let!(:field) { create(:field) }

  before do
    visit root_path
  end

  describe "検索機能" do
    context "検索フォームにキャンプ場名を入力し、検索できること" do
      before do
        fill_in "q[name_cont]", with: field.name
        find("#q_name_cont").send_keys :enter
      end

      it "検索結果が正しく表示されること" do
        expect(page).to have_content "ダダッピロイッパラキャンプ場"
        expect(page).to have_content "岡山県真庭市"
        expect(page).to have_content "000-0000-0000"
      end
      it "キャンプ場詳細ページが正しく表示されること" do
        click_on "ダダッピロイッパラキャンプ場"
        expect(page).to have_content field.name
        expect(page).to have_content "詳細情報"
        expect(page).to have_content "ご予約は「" + field.name + "」HPへどうぞ"
        expect(page).to have_content "マップ"
        expect(page).to have_content "GoogleMapで開く"
        expect(page).to have_content "口コミ"
        expect(page).to have_content "口コミを投稿する"
        expect(page).to have_content "口コミはありません"
        expect(page).to have_content "トップページに戻る"
      end
    end

    context "日本地図の各地区をクリックすると都道府県名から検索できること" do
      it "北海道・東北ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area1').click
        expect(page).to have_content "北海道"
        expect(page).to have_content "青森県"
        expect(page).to have_content "岩手県"
        expect(page).to have_content "宮城県"
        expect(page).to have_content "秋田県"
        expect(page).to have_content "山形県"
        expect(page).to have_content "福島県"
      end
      it "関東ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area2').click
        expect(page).to have_content "茨城県"
        expect(page).to have_content "栃木県"
        expect(page).to have_content "群馬県"
        expect(page).to have_content "埼玉県"
        expect(page).to have_content "千葉県"
        expect(page).to have_content "東京都"
        expect(page).to have_content "神奈川県"
      end
      it "中部ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area3').click
        expect(page).to have_content "新潟県"
        expect(page).to have_content "富山県"
        expect(page).to have_content "石川県"
        expect(page).to have_content "福井県"
        expect(page).to have_content "山梨県"
        expect(page).to have_content "長野県"
        expect(page).to have_content "岐阜県"
        expect(page).to have_content "静岡県"
        expect(page).to have_content "愛知県"
      end
      it "近畿ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area4').click
        expect(page).to have_content "三重県"
        expect(page).to have_content "滋賀県"
        expect(page).to have_content "京都府"
        expect(page).to have_content "大阪府"
        expect(page).to have_content "兵庫県"
        expect(page).to have_content "奈良県"
        expect(page).to have_content "和歌山県"
      end
      it "中国・四国ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area5').click
        expect(page).to have_content "鳥取県"
        expect(page).to have_content "島根県"
        expect(page).to have_content "岡山県"
        expect(page).to have_content "広島県"
        expect(page).to have_content "山口県"
        expect(page).to have_content "徳島県"
        expect(page).to have_content "香川県"
        expect(page).to have_content "愛媛県"
        expect(page).to have_content "高知県"
      end
      it "九州・沖縄ボタンをクリックすると都道府県名が正しく表示されること" do
        find('.area6').click
        expect(page).to have_content "福岡県"
        expect(page).to have_content "佐賀県"
        expect(page).to have_content "長崎県"
        expect(page).to have_content "熊本県"
        expect(page).to have_content "大分県"
        expect(page).to have_content "宮崎県"
        expect(page).to have_content "鹿児島県"
        expect(page).to have_content "沖縄県"
      end
    end

    context "日本地図の各都道府県をクリックするとキャンプ場が検索できること" do
      it "岡山県ボタンをクリックすると岡山県にあるキャンプ場が検索できること" do
        find('.area5').click
        click_on "岡山県"
        expect(page).to have_content "岡山県"
      end
    end

    context "こだわり条件をチェックしてキャンプ場を検索できる" do
      it "ドロップダウンリストから都道府県を選択・検索できること" do
        select "都道府県を選んでください", from: "q[address_cont]"

        # expect(page).to have_content "北海道"
        # expect(page).to have_content "青森県"
        # expect(page).to have_content "岩手県"
        # expect(page).to have_content "宮城県"
        # expect(page).to have_content "秋田県"
        # expect(page).to have_content "山形県"
        # expect(page).to have_content "福島県"

        # expect(page).to have_content "茨城県"
        # expect(page).to have_content "栃木県"
        # expect(page).to have_content "群馬県"
        # expect(page).to have_content "埼玉県"
        # expect(page).to have_content "千葉県"
        # expect(page).to have_content "東京都"
        # expect(page).to have_content "神奈川県"

        # expect(page).to have_content "新潟県"
        # expect(page).to have_content "富山県"
        # expect(page).to have_content "石川県"
        # expect(page).to have_content "福井県"
        # expect(page).to have_content "山梨県"
        # expect(page).to have_content "長野県"
        # expect(page).to have_content "岐阜県"
        # expect(page).to have_content "静岡県"
        # expect(page).to have_content "愛知県"

        # expect(page).to have_content "三重県"
        # expect(page).to have_content "滋賀県"
        # expect(page).to have_content "京都府"
        # expect(page).to have_content "大阪府"
        # expect(page).to have_content "兵庫県"
        # expect(page).to have_content "奈良県"
        # expect(page).to have_content "和歌山県"

        expect(page).to have_content "鳥取県"
        # expect(page).to have_content "島根県"
        expect(page).to have_content "岡山県"
        expect(page).to have_content "広島県"
        # expect(page).to have_content "山口県"
        # expect(page).to have_content "徳島県"
        # expect(page).to have_content "香川県"
        # expect(page).to have_content "愛媛県"
        # expect(page).to have_content "高知県"

        # expect(page).to have_content "福岡県"
        # expect(page).to have_content "佐賀県"
        # expect(page).to have_content "長崎県"
        # expect(page).to have_content "熊本県"
        # expect(page).to have_content "大分県"
        # expect(page).to have_content "宮崎県"
        # expect(page).to have_content "鹿児島県"
        # expect(page).to have_content "沖縄県"

        select "岡山県", from: "q[address_cont]"
        find('.camp-commit').click
        expect(page).to have_content "岡山県"
      end
      it "都道府県を選択、こだわり条件にチェックをしてキャンプ場を絞り込み検索できること" do
        find(:css, '#switch-pets').set(true)
        expect(page).to have_checked_field with: 'true', visible: false
        select "都道府県を選んでください", from: "q[address_cont]"
        select "岡山県", from: "q[address_cont]"
        find('.camp-commit').click
        expect(page).to have_content "岡山県真庭市"
        expect(page).to have_content "ペット： 可"
      end
    end

    context "標高の入力によりキャンプ場が検索できる" do
      it "MINに入力した標高以上のキャンプ場が検索できること" do
        fill_in "q[elevation_gteq]", with: 500
        find('.camp-style').click
        expect(page).to have_content "777"
      end
      it "MINに入力した標高より低いキャンプ場は検索できないこと" do
        fill_in "q[elevation_gteq]", with: 800
        find('.camp-style').click
        expect(page).to have_content "キャンプ場は見つかりませんでした"
      end
      it "MIN〜MAXに入力した標高以下のキャンプ場が検索できること" do
        fill_in "q[elevation_gteq]", with: 100
        fill_in "q[elevation_lteq]", with: 800
        find('.camp-style').click
        expect(page).to have_content "777"
      end
      it "MIN〜MAXに入力した標高より高いキャンプ場は検索できないこと" do
        fill_in "q[elevation_gteq]", with: 0
        fill_in "q[elevation_lteq]", with: 1
        find('.camp-style').click
        expect(page).to have_content "キャンプ場は見つかりませんでした"
      end
      it "入力した標高の範囲内にあるキャンプ場が検索できること" do
        fill_in "q[elevation_gteq]", with: 500
        fill_in "q[elevation_lteq]", with: 800
        find('.camp-style').click
        expect(page).to have_content "777"
      end
      it "入力した標高の範囲外にあるキャンプ場は検索できないこと" do
        fill_in "q[elevation_gteq]", with: 800
        fill_in "q[elevation_lteq]", with: 1200
        find('.camp-style').click
        expect(page).to have_content "キャンプ場は見つかりませんでした"
      end
    end

    context "検索結果が0件のとき" do
      it "0件表示と戻る導線が表示されること" do
        fill_in "q[name_cont]", with: "存在しないキャンプ場名"
        find("#q_name_cont").send_keys :enter

        expect(page).to have_content("検索結果：0件")
        expect(page).to have_content("キャンプ場は見つかりませんでした")
        click_on "トップページに戻る"
        expect(page).to have_current_path(root_path)
      end
    end

    context "ページネーション遷移時に検索条件が維持されること" do
      before do
        10.times do |i|
          create(:field, name: "条件維持テスト#{i}", place_id: "keep_cond_#{i}")
        end
      end

      it "2ページ目遷移後も検索キーワード付きURLになること" do
        fill_in "q[name_cont]", with: "条件維持テスト"
        find("#q_name_cont").send_keys :enter

        page.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        find("a.page-link", text: "2", match: :first).click

        expect(page.current_url).to include("q%5Bname_cont%5D=%E6%9D%A1%E4%BB%B6%E7%B6%AD%E6%8C%81%E3%83%86%E3%82%B9%E3%83%88")
      end
    end

    context "各リンクをクリックするとキャンプ場が検索できること" do
      it "「直火ができるキャンプ場」をクリックすると直火可のキャンプ場が検索できること" do
        click_on "直火ができるキャンプ場"
        expect(page).to have_content "直火：可"
      end
      it "「ウォシュレット検索」をクリックするとウォシュレット式トイレのキャンプ場が検索できること" do
        click_on "ウォシュレット検索"
        click_on "ダダッピロイッパラキャンプ場"
        expect(page).to have_content "ウォシュレット式"
      end
      it "「徒歩で行けるキャンプ場まとめ」をクリックすると最寄り駅から1km以内のキャンプ場が検索できること" do
        click_on "徒歩で行けるキャンプ場まとめ"
        click_on "ダダッピロイッパラキャンプ場"
        expect(field.near_station_km).to be <= 1
      end
      it "「ゆるキャン△聖地(キャンプ場)巡礼」をクリックするとゆるキャン△に登場するキャンプ場が検索できること" do
        click_on "ゆるキャン△聖地(キャンプ場)巡礼"
        click_on "ダダッピロイッパラキャンプ場"
        expect(page).to have_content "ゆるキャン聖地△"
      end
      it "「ふたりソロキャンプ検索」をクリックするとふたりソロキャンプに登場するキャンプ場が検索できること" do
        click_on "直火ができるキャンプ場"
        click_on "ダダッピロイッパラキャンプ場"
        expect(page).to have_content "ふたりソロキャンプ地！"
      end
    end

    context "検索から口コミ投稿・削除まで一連で操作できること" do
      let(:user) { create(:user) }

      it "検索→詳細→投稿→削除を完了できること" do
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        find('input[name="commit"]').click

        visit root_path
        fill_in "q[name_cont]", with: field.name
        find("#q_name_cont").send_keys :enter
        find("a[href='#{field_path(field)}']", text: field.name, match: :first).click
        expect(page).to have_content("口コミ")
        find("a", text: "口コミを投稿する", visible: :all, match: :first).click
        fill_in "review_title", with: "フロー確認タイトル"
        find("img[alt='5']").click
        fill_in "review_content", with: "フロー確認コンテンツ"
        click_on "保存"

        expect(page).to have_content("フロー確認タイトル")
        click_on "削除する"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content("口コミはありません")
      end
    end
  end
end
