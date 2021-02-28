# このアプリケーションについて

## アプリケーション名
Idea＊Chat （アイディアチャット）

## 概要
起業や新規事業を考えている方が対象になります。
特定のチャット部屋を立ち上げ（または入室する）ことで匿名の第三者と１対１で意見交換することができます。

## URL
https://idea-chat-32551.herokuapp.com/

## テスト用アカウント
nickname: テストユーザー１
email:    test@user.com
password: test111

nickname: テストユーザー２
email:    test@user2.com
password: test222

## 利用方法
登録したユーザーのみが、チャットルームを作成・入室・削除権限を持ちます。
相談したい内容をチャットルーム名として作成し、それに興味を持ったユーザーが入室できます。
お互いの意見を交わし、終了したら任意のタイミングで退出します。
退出することで、チャットルームは自動で削除され、チャットログが残りません。

## 目指した課題解決
自分だけのアイディアを閃いたけど、第三者の意見が聞きたい、相談したい人向けのアプリケーションです。
相談はしたいけど、不特定多数の人に見られたくない、内容をいつまでもデータベースに残したくない人にオススメ。
CtoBとして企業への売り込みも出来るのではないかと考えました。

## 洗い出した要件
| 機能                   | 目的                       | 詳細                 | ストーリー                                         |
| ---------------------- | -------------------------- | -------------------- |--------------------------------------------------- |
| ユーザー登録機能       | 登録制によるサービスの提供 | devise gemを使用     | ニックネーム・メールアドレス（一意性）・パスワード |
| チャットルーム作成機能 | チャット機能の提供         | Createで生成される   | ルーム作成時に議題入力しをルーム名とする           |
| チャット投稿機能       | チャット機能の提供         | Createで投稿される   | 送信ボタンを押すことで投稿内容が反映される         |
| チャットルーム削除機能 | チャットログを残さないため | destroyで削除される  | チャットルームから退出することで削除される         |

## 実装した機能について（イメージ）
![2021-02-28 21 44 39](https://user-images.githubusercontent.com/74903855/109419004-8554f380-7a0e-11eb-9dec-e3492cd79ab6.png)

## 追加実装の機能（予定）
| 機能                         | 目的                       | 詳細             | ストーリー                                     |
| ---------------------------- | -------------------------- | -----------------|----------------------------------------------- |
| チャット投稿機能の非同期通信 | 円滑な投稿のやりとりを提供 | JavaScriptを使用 | チャット投稿機能における該当する箇所のIDを取得 |
| オンライン表示機能           | ログイン済みのユーザー判別 | 考えてます       | チャットルーム名に表示させる                   |
| 画像表示（S3）               | 画像表示させる             | S3の導入         | ユーザーの操作に連動させる                     |

## 開発環境
Visual Studio Code 1.53.0 MySQL2

## 本番環境
heroku S3 MySQL2 

# データベース設計
![2021-02-28 21 51 55](https://user-images.githubusercontent.com/74903855/109419128-42dfe680-7a0f-11eb-85a5-8b437e2bfed4.png)

# テーブル設計

## users テーブル

| Column   | Type   | Options                   |
| -------- | ------ | ------------------------- |
| nickname | string | null: false               |
| email    | string | null: false, unique: true |
| password | string | null: false, unique: true |

### Association

- has_many :rooms
- has_many :messages

## rooms テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| name    | string     | null: false       |
| user_id | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :messages

## messages テーブル

| Column     | Type           | Options                        |
| ---------- | -------------- | ------------------------------ |
| content    | string         |                                |
| user_id    | references     | null: false, foreign_key: true |
| room_id    | references     | null: false, foreign_key: true |
| image      | active_storage |                                |


### Association

- belongs_to :room
- belongs_to :user
