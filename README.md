# TO_CAMP
キャンプ場検索に特化したWebアプリケーションです。<br>
様々な条件でキャンプ場を検索することができます。<br>
また、キャンプ場ごとの情報を豊富にまとめているため、知りたい情報をひと目で知れるような構成にしています。<br>
レスポンシブ対応していますので、スマホやタブレットからもご確認可能です。<br>

※現在、TO_CAMPでは「広島県・岡山県・鳥取県」のキャンプ場データを検索できます。R3.8.26時点<br>
キャンプ場は随時追加予定です。<br>

▼URLはこちら▼<br>
https://www.to-camp.com<br>

<img width="973" alt="スクリーンショット 2021-08-25 16 11 37" src="https://user-images.githubusercontent.com/78259954/130743498-7ea1b905-f6c4-4852-bc13-eae338dc63d3.png">

現在、実際にサービスとしてリリース・運用しており、最終的には、全国約4000箇所以上のキャンプ場情報を検索対象に含めます。<br>
また、ポートフォリオはQiitaでも紹介記事を書いています。<br>
▼QiitaURLはこちら▼<br>
https://qiita.com/s7056i3056/items/841197ee506ceac52192<br>

## 使用技術
・Ruby 2.6.8<br>
・Ruby on Rails 6.1.4<br>
・Puma 5.3.2<br>
・Docker 20.10.6<br>
・MySQL 8.0<br>
・AWS S3<br>
・CI/CD CircleCI<br>
・RSpec<br>
・Rubocop<br>
・Heroku<br>

## 機能一覧
・ログイン機能(devise)<br>
-アイコン設定、ユーザー名登録<br>
-ゲストログイン機能<br>
・パスワードリセット機能(MailGun)<br>
・検索機能(ransack)<br>
-キャンプ場名検索<br>
-都道府県検索<br>
-各種条件絞り込み検索<br>
・ローディング(jQuery)<br>
-検索時ローディング画面表示<br>
・口コミ機能<br>
・星評価機能<br>
-JQuery Raty.js<br>
-星評価平均値算出<br>
・ページネーション(kaminari)<br>
-並べ替え機能<br>
・ブックマーク機能<br>
・SNSシェアボタン<br>
-Twitter、Facebook、LINE<br>
・Google maps API<br>
・管理者機能(active admin)<br>
・お問い合わせ機能(Google form)<br>
・画像リサイズ(imagemagick, minimagick)<br>
・SEO対策<br>
-メタタグ(meta-tags)<br>
-サイトマップ(sitemap_generator, roboto, whenever)<br>
-サイト解析(google-analytics-rails)<br>

## テストフレームワーク
・RSpec<br>
-factories<br>
-models spec<br>
-requests spec<br>
-system spec<br>

## ER図
ER図は「MySQL Workbench」を使って作成しました。<br>

<img width="967" alt="スクリーンショット 2021-08-26 13 08 15" src="https://user-images.githubusercontent.com/78259954/130899450-bd275a20-fb84-481d-a85d-65402ea30ea4.png">

## インフラ構成図
本番環境のインフラ構成図です。<br>
CircleCIによる自動デプロイの流れも補足しました。<br>
Dockerfileをpushし、Heroku側でbuildする方式を使っています。<br>

![TO_CAMP インフラ構成図](https://user-images.githubusercontent.com/78259954/130965489-e031b1dd-0525-4b6b-8c38-65bcfbdb02df.png)