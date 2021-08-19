# TO_CAMP
キャンプ場をお好みの条件で検索できる「キャンプ場検索サービス」です。<br>
最終的には、全国約4000箇所以上のキャンプ場情報を検索対象にします。<br>

## 使用技術
・Ruby 2.6.8<br>
・Ruby on Rails 6.1.3<br>
・Puma<br>
・Docker<br>
・MySQL 8.0<br>
・AWS S3<br>
・CircleCI<br>
・RSpec<br>
・Rubocop<br>
・Heroku<br>

## 機能一覧
・ログイン機能(Devise)<br>
-アイコン設定、ユーザー名登録<br>
-ゲストログイン機能<br>
・パスワード再設定機能(devise mailer)<br>
・検索機能(Ransack)<br>
-キャンプ場名検索<br>
-都道府県検索<br>
-各種条件絞り込み検索<br>
・口コミ機能<br>
・星評価機能<br>
-JQuery Raty.js<br>
-星評価平均値算出<br>
・ページネーション(Kaminari)<br>
-並べ替え機能<br>
・ブックマーク機能<br>
・SNSシェアボタン<br>
-Twitter、Facebook、LINE<br>
・Google maps API<br>
・管理者機能(active admin)<br>
・問い合わせ機能(Google form)<br>
・画像リサイズ(imagemagick)

## テスト
・RSpec<br>
-models spec<br>
-requests spec<br>
-system spec<br>