class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

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

   def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました。'
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

  def redirect_if_sold_out
    if @item.purchase.present?
      redirect_to root_path, alert: '売却済み商品の編集はできません。'
    end
  end

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_days_id, :price, :image).merge(user_id: current_user.id)
  end
end