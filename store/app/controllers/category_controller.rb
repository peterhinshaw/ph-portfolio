class CategoryController < ApplicationController
   def list
      @category = Category.find(:all)
   end
end
