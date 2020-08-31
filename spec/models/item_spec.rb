require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    context '商品の出品ができる時' do
      it '商品画像、商品名、商品説明、カテゴリー、商品の状態、配送料負担、発送元地域、発送までの日数、価格が存在すれば出品できること' do
        expect(@item).to be_valid
      end

      it '価格の範囲が¥300~¥9,999,999の間でかつ半角数字での入力であれば出品できること' do
        @item.price = '1234567'
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない時' do
      it '商品画像が空では出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では出品できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空では出品できないこと' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報が空では出品できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
      end

      it '商品状態の情報が空では出品できないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", 'Condition is not a number')
      end

      it '配送料負担の情報が空では出品できないこと' do
        @item.ship_expense_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship expense can't be blank", 'Ship expense is not a number')
      end

      it '配送元地域の情報が空では出品できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
      end

      it '発送までの日数が空では出品できないこと' do
        @item.period_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Period can't be blank", 'Period is not a number')
      end

      it '価格が空では出品できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is invalid', 'Price is not a number')
      end

      it '価格は半角数字のみ入力できること' do
        @item.price = 'あした'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    
      it '価格の範囲が~¥299では出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.messages).to include(:price => ["must be greater than or equal to 300"])
      end

      it '価格の範囲が¥10000000~では出品できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.messages).to include(:price => ["must be less than or equal to 9999999"])
      end
    end
  end
end
