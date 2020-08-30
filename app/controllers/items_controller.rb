class ItemsController < ApplicationController
  def index
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
end
