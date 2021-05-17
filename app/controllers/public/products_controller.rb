class Public::ProductsController < ApplicationController
  def index
    @products = Product.where(is_active: true).page(params[:page]).per(8)
  end

  def show
  end
  
end
