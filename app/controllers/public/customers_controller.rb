class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
  end

  def out
  end

  def out_confirm
  end
  
  
  
  private
  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :tel, :email, :is_deleted)
  end
  
end
