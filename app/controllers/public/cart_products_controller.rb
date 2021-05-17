class Public::CartProductsController < ApplicationController
  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += cart_product.product.tax_price * cart_product.quantity
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end
end
