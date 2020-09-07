class OrderAddress
  include ActiveModel::Model
  attr_accessor :order_address, :user_id, :item_id, :token, :price, \
                :postal_code, :prefecture_id, :city_name, :block_number, :building, :phone_number

  POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  PHONE_NUMBER_REGEX = /\A[0-9]{1,11}\z/
  validates :token, :postal_code, :prefecture_id, :city_name, :block_number, :phone_number, presence: true
  validates :postal_code, format: { with: POSTAL_CODE_REGEX }
  validates :phone_number, format: { with: PHONE_NUMBER_REGEX }
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city_name: city_name, \
                   block_number: block_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end
