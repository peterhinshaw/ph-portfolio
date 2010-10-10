p = Product.find(:all)
p.each do |prod|
  prod.count_on_hand = 0 if ! prod.has_stock? 
  prod.save
end
