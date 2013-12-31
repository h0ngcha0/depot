class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @current_time = Time.now
    @products = Product.all
    @cart = current_cart
  end
end
