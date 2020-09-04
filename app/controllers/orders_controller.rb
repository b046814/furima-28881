class OrdersController < ApplicationController
  before_action :move_to_root, only: :index

  def index
  end

  private
  def move_to_root
    @item = Item.find(params[:item_id])
    return if user_signed_in? && @item.order == nil && current_user.id != @item.user_id
    
    redirect_to root_path
  end
end
