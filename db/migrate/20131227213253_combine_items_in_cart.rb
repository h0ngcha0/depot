class CombineItemsInCart < ActiveRecord::Migration
  def change
    # replace multiple items for a single product in a cart with a
    # single item
    Cart.all.each do |cart|
      sum = cart.line_items.group(:product_id).sum(:quantity)

      sum.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(:product_id => product_id).delete_all
          cart.line_items.create(:product_id => product_id, :quantity => quantity)
        end
      end
    end
  end
end
