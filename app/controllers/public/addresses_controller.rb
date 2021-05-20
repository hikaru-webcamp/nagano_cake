class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @address = Address.new
    @addresses = Address.where(customer: current_customer)
  end

  def create
    @address = Address.new(address_params)
    @address.customer = current_customer
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.where(customer: current_customer)
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private
  def address_params
    params.require(:address).permit(:address_name, :address, :postal_code)
  end
  
end
