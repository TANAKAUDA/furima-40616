require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '購入がうまくいくとき' do
      it '全ての情報が正しく入力されている場合、購入できる' do
        expect(@purchase_form).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it '郵便番号が空では購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が正しいフォーマットでないと購入できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県が空では購入できない' do
        @purchase_form.prefecture_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @purchase_form.home_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Home number can't be blank")
      end

      it '電話番号が空では購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁以上11桁以内でないと購入できない' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では購入できない' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号にハイフンが含まれていると購入できない' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'トークンが空では購入できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end