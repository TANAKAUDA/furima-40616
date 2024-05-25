class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :home_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be '---'" }
    validates :city
    validates :home_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(purchase_id: purchase.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, home_number: home_number, building_name: building_name, phone_number: phone_number)
  end
end