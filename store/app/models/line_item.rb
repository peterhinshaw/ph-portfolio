

class LineItem < ActiveRecord::Base
  
  belongs_to :order
  belongs_to :item

  
  def self.from_cart_item(cart_item)
    li = self.new
    li.item        = cart_item.item
    li.quantity    = cart_item.quantity
    li.total_price = cart_item.price
    li
  end
  

end

