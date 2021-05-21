class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = current_customer.orders
  end

  def show
   @order = Order.find(params[:id])
  end

  def new
    if cart_products = CartProduct.where(customer_id: current_customer.id).present?
      @order = Order.new
      @customer = Customer.find(current_customer.id)
      @customer_adresses = Address.where(customer_id: current_customer.id)
    else
      redirect_to cart_products_path, alert: "カートに商品が入っておりません"
    end
  end

  def create
    order = Order.new(order_params)
    order.save
    cart_products = CartProduct.where(customer_id: current_customer.id)
    cart_products.each do |cart_product|
      OrderDetail.create(
        product_id: cart_product.product.id,
        order_id: order.id,
        quantity: cart_product.quantity,
        tax_included_price: cart_product.product.tax_price
        )
    end
    cart_products.destroy_all
    redirect_to thanks_orders_path
  end

  def confirm
    @order = Order.new
    @cart_products = CartProduct.where(customer_id: current_customer.id)
    # 合計金額
    @tax_total_price = 0
    @cart_products.each do |cart_product|
      @tax_total_price += cart_product.product.tax_price * cart_product.quantity
    end
    # orderの処理
    @order.shipping_fee = 800
    @order.total_price = @tax_total_price + @order.shipping_fee
    @order.payment_method = params[:order][:payment_method]
    @order.customer_id = current_customer.id
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.address_name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
      if params[:customer_address].present?
        @address = Address.find(params[:customer_address])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.address_name = @address.address_name
      else
        redirect_to new_order_path, alert: "登録済住所がありません"
      end
    else
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.address_name = params[:order][:address_name]
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_fee, :total_price, :payment_method, :address_name, :address, :postal_code)
  end
end
