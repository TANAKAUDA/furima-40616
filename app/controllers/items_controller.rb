class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update,]
  before_action :correct_user, only: [:edit, :update,]

  def index
    @items = Item.order(created_at: :desc)
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
     @item = Item.find(params[:id])
   end

   def edit
   end
 
   def update
     if @item.update(item_params)
       redirect_to @item, notice: '商品情報が更新されました。'
     else
       render :edit
     end
   end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    unless current_user == @item.user
      redirect_to root_path, alert: '権限がありません。'
    end
  end

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_days_id, :price, :image).merge(user_id: current_user.id)
  end
end