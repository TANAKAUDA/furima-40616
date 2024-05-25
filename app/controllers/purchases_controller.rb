class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_invalid_user

  def index
    gon.public_key = Rails.application.credentials.payjp[:public_key]
    @purchase_form = PurchaseForm.new
  end

  def create
    gon.public_key = Rails.application.credentials.payjp[:public_key]
    @purchase_form = PurchaseForm.new(purchase_params)

    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :home_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_user
    redirect_to root_path if current_user == @item.user || @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
