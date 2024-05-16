class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters' }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'must be full-width katakana characters' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'must be full-width katakana characters' }
  validates :birth_date, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "should include at least one letter and one digit" }
  validates :password, format: { without: /[^\x01-\x7E]+/, message: "cannot include full-width characters" }
end
