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
| birth_date   | date    | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| ship_expense_id | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| period_id       | integer    | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
*imageはActiveStorageで紐付けます*

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city_name     | string     | null: false                    |
| block_number  | string     | null: false                    |
| building      | string     | default: ""                    |
| phone_number  | string    | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order