class StoreController < ApplicationController
  def index
    @current_time = Time.now
    @products = Product.all
    @cart = current_cart
  end
end
