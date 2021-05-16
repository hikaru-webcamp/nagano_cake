class Public::CartProductsController < ApplicationController
  def index
  end

  def create
      cart_product = CartProduct.new(cart_product_params)
      cart_product.customer_id = current_customer.id
    if cart_product.quantity != 0
      cart_product.save
      redirect_to cart_products_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end
  
  private
  
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity, :customer_id)	
  end
end
