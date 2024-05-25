class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_days
  has_one_attached :image
  has_one :purchase

  validates :item_name, presence: { message: "can't be blank" }
  validates :description, presence: { message: "can't be blank" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_days_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: { message: "can't be blank" }
  with_options numericality: { only_integer: true } do
    validates :price, numericality: { greater_than_or_equal_to: 300, message: "must be greater than or equal to 300" }
    validates :price, numericality: { less_than_or_equal_to: 9999999, message: "must be less than or equal to 9999999" }
    validates :price, numericality: { message: "is not a number" }
  end
  validates :image, presence: { message: "can't be blank" }
end