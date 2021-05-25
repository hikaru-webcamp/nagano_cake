class Public::ProductsController < ApplicationController
  def index
    @products = Product.where(is_active: true).order(updated_at: :desc).page(params[:page]).per(8)
  end

  def show
    # 商品情報の取得
    @product = Product.find(params[:id])
    # form_withのための空のインスタンス
    @cart_product = CartProduct.new
  end

end
