require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '注文情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    context '注文情報を保存できる時' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it '建物の情報は空でも保存できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end

    context '注文情報を保存できない時' do
      it 'tokenの情報が空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号の情報が空では保存できない' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンが無ければ保存できない' do
        @order_address.postal_code = '1235555'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '郵便番号のハイフンの前が半角数字3文字で無ければ保存できない' do
        @order_address.postal_code = '12-3555'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '郵便番号のハイフンの後ろが半角数字4文字で無ければ保存できない' do
        @order_address.postal_code = '123-355'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県の情報が空では保存できない' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
      end

      it '都道府県情報のidが1の場合は保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '市区町村の情報が空では保存できない' do
        @order_address.city_name = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City name can't be blank")
      end

      it '番地の情報が空では保存できない' do
        @order_address.block_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block number can't be blank")
      end

      it '電話番号の情報が空では保存できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が半角数字12文字以上では保存できない' do
        @order_address.phone_number = '111222333444'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が半角数字以外では保存できない' do
        @order_address.phone_number = '６６６７８９０'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
