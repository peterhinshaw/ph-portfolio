
class CartItem
  
  attr_reader :item, :quantity
  
  def initialize(item)
    @item = item.id
    @quantity = 1
  end
  
  def set_quantity(new_quantity)
	
	  if new_quantity < 0
		  new_quantity = 0
	  end
	  @quantity = new_quantity
  end
  
  def find(id)
    
  end

  def increment_quantity
    @quantity += 1
  end
  
  def decrement_quantity
    if @quantity > 1
      @quantity -= 1
    else
      @quantity = 0
    end
    nil
  end
  
  def images
    #@item.images
    Item.find(@item).images
  end
  
  def description
    Item.find(@item).description
  end
  
  def title
    Item.find(@item).title
  end
  
  def price
    Item.find(@item).price * @quantity
  end

  def shipping
    Item.find(@item).shipping * @quantity
  end
end
