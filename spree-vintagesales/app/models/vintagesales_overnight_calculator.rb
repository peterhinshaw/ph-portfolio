class Calculator::VintageSalesOvernightCalculator < Calculator
  
  def self.description
    I18n.t("vs_overnight_shipping")
  end

  def self.register
    super                                
    ShippingMethod.register_calculator(self)
    ShippingRate.register_calculator(self)
  end
  
  def compute(order)
#  parameter "order" represents the line_items for the order
    return if order.nil?
    
    @return_value = 0
    order.each {|line_item|
      if line_item.variant.product.taxons[0].name == "Books"
         @return_value += 10
      else 
        @index = 0
        line_item.variant.product.properties.each {|x|
          if x.name == "overnight shipping" 
             @prop_value = line_item.variant.product.product_properties.at(@index).value.tr('$ ','')
             @return_value += @prop_value.to_i
             break
 	  else
	     @index += 1
          end
          }
      end
    }
    @return_value = @return_value
    return @return_value.to_s
  end  
end
