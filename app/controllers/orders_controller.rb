class OrdersController < ApplicationController
  before_action :move_to_root, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(token: order_params[:token], item_id: order_params[:item_id], price: order_params[:price], user_id: order_params[:user_id], postal_code: order_params[:order_address][:postal_code], prefecture_id:  order_params[:order_address][:prefecture_id], city_name: order_params[:order_address][:city_name], block_number: order_params[:order_address][:block_number], building: order_params[:order_address][:building], phone_number: order_params[:order_address][:phone_number])
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency:'jpy'
    )
  end

  def order_params
    params.permit(:token, :item_id, :price, order_address: [:postal_code, :prefecture_id, :city_name, :block_number, :building, :phone_number]).merge(user_id: current_user.id)
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    return if user_signed_in? && @item.order == nil && current_user.id != @item.user_id
    
    redirect_to root_path
  end
end
