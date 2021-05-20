class Public::HomesController < ApplicationController
  def top
    @products = Product.where(is_active: true).order(updated_at: :desc).limit(4)
  end

  def about
  end
end
