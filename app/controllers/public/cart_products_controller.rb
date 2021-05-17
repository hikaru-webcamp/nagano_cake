class Public::CartProductsController < ApplicationController
  def index
  end

  def create
    cart_product = CartProduct.new(cart_product_params)
    cart_product.customer_id = current_customer.id
    if cart_product.save
      redirect_to cart_products_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    cart_product = CartProduct.find(params[:id])
    cart_product.update(cart_product_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart_product = CartProduct.find(params[:id])
    cart_product.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    cart_products = CartProduct.where(customer_id: current_customer.id)
    cart_products.destroy_all
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)	
  end
end
