#---
# Excerpted from "Agile Web Development with Rails, 2nd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails2 for more book information.
#---
# Schema as of June 12, 2006 15:45 (schema version 7)
#
# Table name: orders
#
#  id       :integer(11)   not null, primary key
#  name     :string(255)   
#  address  :text          
#  email    :string(255)   
#  pay_type :string(10)    
#




class Order < ActiveRecord::Base


  
  has_many :line_items


  
  PAYMENT_TYPES = [
    #  Displayed        stored in db
    [ "Check",          "check" ],
    [ "Credit card",    "cc"   ],
    [ "Purchase order", "po" ]
  ]
  
  # ...
  

  
  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map {|disp, value| value}
  
  # ...
  

  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li 
    end 
  end 
  



end

