class Cart 
  
  attr_reader :cartitems
  
  def empty?
    @cartitems.empty?
  end

  def initialize
    @cartitems = []
  end 

  def find_cartitem_by_title(title)
	  @cartitems.find {|itm| itm.title == title}
  end
  
  def add_item(item)
#    debugger if ENV['RAILS_ENV'] == 'development'
    @current_cartitem = @cartitems.find {|itm| itm.title == item.title}
    if @current_cartitem
      @current_cartitem.increment_quantity
    else
      @current_cartitem = CartItem.new(item)
      @cartitems << @current_cartitem
    end
    @current_cartitem
  end 

  def remove_item(item)
    @cartitems.delete_if {|cartitem| cartitem.title == item }
  end 

  def update_quantity(title, quantity)
       @current_cartitem = @cartitems.find {|itm| itm.title == title}
       @current_cartitem.set_quantity(quantity)
  end 
  
  def total_items
    @cartitems.sum { |cartitem| cartitem.quantity }
  end 
  
  def total_price
    @cartitems.sum { |cartitem| cartitem.price  + cartitem.shipping}
  end
end
