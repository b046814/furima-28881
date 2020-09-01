class ItemsController < ApplicationController

  before_action :set_item, only: :show

  def index
    @items = Item.includes(:order).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = @item.user
    @order = @item.order
  end

  def calculated
    price = params[:num].to_i
    num_fee = price / 10
    num_profit = price - num_fee
    calculation = { fee: num_fee, profit: num_profit }
    render json: { post: calculation }
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :ship_expense_id, :prefecture_id, :period_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
