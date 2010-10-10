class StoreController < ApplicationController
  
  before_filter :find_cart, :except => :empty_cart
    
   def index
#      debugger if ENV['RAILS_ENV'] == 'development'
      @items = Item.description_search(params[:description_search])
   end
 
  def view_cart
    @cart = find_cart
    if @cart.empty?
	    session[:cart] = nil
    end
  end

  def filter_categories
#        debugger if ENV['RAILS_ENV'] == 'development'
      if params[:description]
          @category_index = params[:description].keys[0].to_i
	  @store_category = Category.find(@category_index)
	  @search = params[:description].values[0]
      end
      @items = Item.description_search_by_category(@store_category, @search)
   end
   def show
	   debugger if ENV['RAILS_ENV'] == 'development'
      @item = Item.find(params[:id])
   end

def show_categories
#        debugger if ENV['RAILS_ENV'] == 'development'
      if params[:id]
          @store_category = Category.find(params[:id])
      end
      @category_index = params[:id]
      @items = Item.description_search_by_category(@store_category, params[:description])
   end
   
  def empty_cart
   #debugger if ENV['RAILS_ENV'] == 'development'
    @cart = find_cart
    for cartitem in @cart.cartitems 
#      remove_from_cart(cartitem.title)
      @title = cartitem.title
      @item = Item.find(:first, :conditions => ["title = ?", @title])
      @cartitem = @cart.find_cartitem_by_title(@title)
      @item.increment_quantity(@cartitem.quantity)
      @cart.remove_item(@title)
    end
    session[:cart] = nil
    redirect_to_index
  end 

def remove_from_cart(title=nil)
    #debugger if ENV['RAILS_ENV'] == 'development'
      if title == nil
	      title = params[:id]
	      end
      @title = title
      @item = Item.find(:first, :conditions => ["title = ?", @title])
      @cartitem = @cart.find_cartitem_by_title(@title)
      @item.increment_quantity(@cartitem.quantity)
      @cart.remove_item(@title)
      redirect_to_index unless request.xhr?
  end

  def set_quantity
      @new_quantity = params[:cartitem]
      @quan = @new_quantity[:quantity].to_i
      
      @title = params[:id]
      @item = Item.find(:first, :conditions => ["title = ?", @title])
      @cartitem = @cart.find_cartitem_by_title(@title)
      
      begin
         if @quan > @cartitem.quantity  # new count is more
           @item.decrement_quantity(@quan - @cartitem.quantity)
	 else
	    @item.increment_quantity(@quan - @cartitem.quantity)
         end
      rescue ActiveRecord::RecordInvalid
        logger.error("Attempt to access invalid product #{params[:id]}")
        redirect_to_index("Sorry, there is insufficient quantity available to match your request")
      else
        @cart.update_quantity(params[:id], @quan)
        redirect_to_index unless request.xhr?
      end
  end

  def add_to_cart
    #debugger if ENV['RAILS_ENV'] == 'development'
    begin                     
      item = Item.find(params[:id])  
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid item")
    else
       if item.quantity ==0
	      redirect_to_index("Sorry, your item is sold out")
       else
	 item.decrement_quantity
         @current_item = @cart.add_item(item)
         redirect_to_index unless request.xhr?
      end
    end
  end

  def checkout
    if @cart.cartitems.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  
  def save_order
    @order = Order.new(params[:order])  
    @order.add_line_items_from_cart(@cart)
    if @order.save        
      session[:cart] = nil
      redirect_to_index("Thank you for your order")
    else
      render :action => :checkout
    end
  end
  
  private
  
#  def redirect_to_index(msg = nil)
#    flash[:notice] = msg if msg
#    redirect_to :action => :index
#  end

  def redirect_to_item_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => :index, :controller => "item"
  end
  
  def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end


end
