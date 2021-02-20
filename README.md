# このアプリケーションについて

## アプリケーション名
IdeaChat （アイディアチャット）

## 概要
起業や新規事業を考えている方が対象になります。
特定のチャット部屋を立ち上げ（または入室す）ることで匿名の第三者と１対１で意見交換することができます。

## URL
製作中のためまだございません。

## テスト用アカウント
製作中のためまだございません。

## 利用方法
登録したユーザーのみが、チャットルームを作成・入室・削除権限を持ちます。
相談したい内容をチャットルーム名として作成し、それに興味を持ったユーザーが入室できます。
お互いの意見を交わし、終了したら任意のタイミングで退出します。
退出することで、チャットルームは自動で削除され、チャットログが残りません。

## 目指した課題解決
自分だけのアイディアを考えたけれど、第三者の意見が聞きたい、相談したい。
相談したいが、不特定多数の人に見られたくない、内容を残したくない。

## 洗い出した要件
| 機能                   | 目的                       | 詳細                 | ストーリー                                         |
| ---------------------- | -------------------------- | -------------------- |--------------------------------------------------- |
| ユーザー登録機能       | 登録制によるサービスの提供 | devise gemを使用     | ニックネーム・メールアドレス（一意性）・パスワード |
| チャットルーム作成機能 | チャット機能の提供         | Createで生成される   | ルーム作成時に議題入力しをルーム名とする           |
| チャット投稿機能       | チャット機能の提供         | Createで投稿される   | 送信ボタンを押すことで投稿内容が反映される         |
| チャットルーム削除機能 | チャットログを残さないため | destroyで削除される  | チャットルームから退出することで削除される         |

## 実装した機能についてのGIFと説明
作成中のためまだございません。

## 追加実装の機能（予定）
| 機能                         | 目的                       | 詳細             | ストーリー                                     |
| ---------------------------- | -------------------------- | -----------------|----------------------------------------------- |
| チャット投稿機能の非同期通信 | 円滑な投稿のやりとりを提供 | JavaScriptを使用 | チャット投稿機能における該当する箇所のIDを取得 |
| オンライン表示機能           | ログイン済みのユーザー判別 | 考えてます       | チャットルーム名に表示させる                   |
| 広告機能                     | 議題の参考のため           | 考えてます       | チャットルーム内に議題に関連する書籍など表示   |

## ローカルでの動作方法
作成が落ち着いたら書きます。


# データベース設計
ER図を御覧ください。

# テーブル設計

## users テーブル

| Column   | Type   | Options                   |
| -------- | ------ | ------------------------- |
| nickname | string | null: false               |
| email    | string | null: false, unique: true |
| password | string | null: false, unique: true |

### Association

- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages

## rooms テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :room_users
- belongs_to :user
- has_many :messages

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user