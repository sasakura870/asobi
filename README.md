# Asobi
![top](https://user-images.githubusercontent.com/52036434/70401738-438c0600-1a74-11ea-8cfa-2cd9f5997ac3.png)
Asobiは様々なローカルルールや自分で考えた遊びを記録・共有するサービスです。

# URL
http://www.asobi-app.com/

# 主な機能
## ユーザー登録
![signup](https://user-images.githubusercontent.com/52036434/70401735-438c0600-1a74-11ea-856c-e2afa9d9cbd7.png)
ユーザーID, メールアドレス, パスワードを入力することで仮登録ができます。
登録後に送信されるメールに記載されているリンクから本登録が完了します。
また、ヘッダーアイコンをクリックすると出てくるユーザーメニューの「設定」から各種設定ができます。

また、ユーザー登録不要のゲストログインも可能です。ページ上部のヘッダーから簡単にゲストログインできます。
ゲストユーザーは本登録ユーザーと同様の機能が使えます(メールアドレス変更、退会のみ不可)

## 投稿
![post](https://user-images.githubusercontent.com/52036434/70401734-42f36f80-1a74-11ea-9770-7671c10555c6.png)
登録したユーザーはヘッダーメニューから遊びを作成することができます。
遊びには「タイトル」「概要」「タグ」「本文」の項目があり、それぞれ記載することで遊びの投稿が可能です。
本文には、よりよく記述するための様々な編集機能をお使いいただけます。

また、遊びを下書き保存することも可能です。保存した下書きはユーザーメニューから閲覧、編集が可能です。

## 閲覧
![article](https://user-images.githubusercontent.com/52036434/70401732-42f36f80-1a74-11ea-8f14-b1bbfddc74c8.png)
投稿された遊びは全てのユーザーが閲覧できます。
登録済みのユーザーは画面左のボタンから遊びに「いいね」をつけることができます。気に入った遊びには是非いいねを付けましょう。
また、遊びにコメントすることも可能です。

## タグ
![tag](https://user-images.githubusercontent.com/52036434/70401736-438c0600-1a74-11ea-8227-670cc65e7206.png)
遊びには「タグ」を5つまでつけることができます。
タグが付けられた遊びの一覧を見ることができるので、関連するタグを付けてユーザーに見つけてもらいやすくしましょう。

## 検索
![search](https://user-images.githubusercontent.com/52036434/70402073-708ce880-1a75-11ea-9991-91f5a675f218.png)
ヘッダーの検索窓からキーワード検索ができます。
キーワードを入力して検索することで、キーワードに関連する「ユーザー」「遊び」「タグ」を探すことができます。
検索を利用してお気に入りの遊びを探しましょう。

## フォロー
登録済みのユーザーはユーザーとタグを「フォロー」することができます。
フォローすることで、トップページのタイムラインにフォローしたユーザーとタグの新着の遊びが表示されます。

## Asobiガチャ
![capsule_toy](https://user-images.githubusercontent.com/52036434/70401733-42f36f80-1a74-11ea-9ecc-89dc4795aed2.png)
Asobiの特徴として、「Asobiガチャ」機能があります。
これはAsobiに投稿された遊びをランダムに1つ表示する機能です。
トップページまたは遊びの詳細画面のボタンからAsobiガチャを引くことができます。
是非Asobiガチャを引いてまだ見ぬ遊びに出会いましょう。

# 使用技術

## バックエンド
+ Ruby 2.6.3
+ Ruby on Rails 6.0.0
  - Webpacker 4.39.3
  - ActiveStorage
  - ActionText
  - slim 4.0.1
  - kaminari 1.1.1
  - ActiveRecord-Import 1.0.3
  - counter_culture 2.2.4
+ RSpec 3.9

## フロントエンド
+ Vue.js 2.6.10
  - Vue Croppa 1.3.8
+ FontAwesome 5.10.2
+ sweetalert2 8.18.3
+ Tippy.js 5.1.1
+ selectize.js 0.12.6


SCSSはフレームワークを使わず、[FLOCSS](https://github.com/hiloki/flocss)に基づいて作成しました。

## インフラ
+ AWS
  - VPC
  - EC2
  - Route 53
  - RDS
    * PostgreSQL 11.5
  - S3
+ Nginx 1.16.1
+ Unicorn 5.5.1

