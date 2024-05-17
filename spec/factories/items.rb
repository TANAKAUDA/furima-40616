FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category_id { 2 } # Assuming 1 is the "---" and 2 is a valid category
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_days_id { 2 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end