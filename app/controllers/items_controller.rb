class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :destroy]
  before_action :authenticate_user!, only: :new

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

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
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
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :ship_expense_id, \
                                 :prefecture_id, :period_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_root
    return if user_signed_in? && current_user.id == @item.user_id

    redirect_to root_path
  end
end
