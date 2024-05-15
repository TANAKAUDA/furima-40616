## users テーブル

| Column                  | Type   | Options     |
| ----------------------- | ------ | ----------- |
| nickname                | string | null: false |
| email                   | string | null: false , unique:true|
| encrypted_password      | string | null: false |
| last_name               | string | null: false |
| first_name              | string | null: false |
| last_name_kana          | string | null: false |
| first_name_kana         | string | null: false |
| birth_data              | date   | null: false |

### Association

- has_many :items
- has_many :purchases



## items テーブル

| Column                  | Type       | Options     |
| ----------------------- | ------     | ----------- |
| user                    | references | null: false, foreign_key:true |
| item_name               | string     | null: false |
| description             | text       | null: false |
| category                | string     | null: false |
| condition               | string     | null: false |
| shipping_payer          | string     | null: false |
| shipping_from_area      | string     | null: false |
| shipping_days           | string     | null: false |
| price                   | decimal    | null: false |

### Association

- belongs_to :user
- has_one :purchase
- has_one_attached :image


## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address



## addresses テーブル

| Column                  | Type       | Options     |
| ----------------------- | ------     | ----------- |
| purchase                | references | null: false, foreign_key:true |
| postal_code             | string     | null: false |
| prefecture              | text       | null: false |
| city                    | string     | null: false |
| home_number             | string     | null: false |
| building_name           | string     |             |
| phone_number            | string     | null: false |

### Association

- belongs_to :purchase