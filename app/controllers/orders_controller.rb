class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params[:order_address])
    @order_address.item_id = order_params[:item_id]
    @order_address.user_id = order_params[:user_id]
    @order_address.token = order_params[:token]
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def order_params
    params.permit(:token, :item_id, :price, order_address: [:postal_code, :prefecture_id, :city_name, :block_number, \
                                                            :building, :phone_number]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    return if user_signed_in? && @item.order.nil? && current_user.id != @item.user_id

    redirect_to root_path
  end
end
