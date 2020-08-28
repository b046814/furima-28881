# テーブル設計

## users テーブル

| Column       | Type    | Options                   |
| ------------ | ------- | ------------------------- |
| nickname     | string  | null: false               |
| email        | string  | null: false, unique: true |
| password     | string  | null: false               |
| last_name    | string  | null: false               |
| first_name   | string  | null: false               |
| last_name_k  | string  | null: false               |
| first_name_k | string  | null: false               |
| birth_year   | integer | null: false               |
| birth_month  | integer | null: false               |
| birth_date   | integer | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :places

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item_name       | string     | null: false                    |
| description     | text       | null: false                    |
| category_id     | string     | null: false                    |
| condition_id    | string     | null: false                    |
| ship_expense_id | string     | null: false                    |
| prefecture_id   | string     | null: false                    |
| period_id       | string     | null: false                    |
| price           | integer    | null: false                    |
| user_id         | references | null: false, foreign_key: true |
*imageはActiveStorageで紐付けます*

### Association

- belongs_to :user
- has_one :purchase
- has_one :place

## purchases テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| card_number      | string     | null: false                    |
| expiration_month | integer    | null: false                    |
| expiration_year  | integer    | null: false                    |
| security_code    | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :place

## places テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| city_name     | string     | null: false                    |
| block_number  | string     | null: false                    |
| building      | string     |                                |
| phone_number  | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| purchase_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :purchase