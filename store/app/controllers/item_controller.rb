class ItemController < ApplicationController
   # items_controller.rb
   def index
#      debugger if ENV['RAILS_ENV'] == 'development'
      @items = Item.description_search(params[:description_search])
   end
   def list
      @items = Item.find(:all)
      @categories = Category.find(:all)
   end
   def show
      @item = Item.find(params[:id])
   end
   def new
      @item = Item.new
      @categories = Category.find(:all)
      @file_count = 0
   end
   def create
      #debugger if ENV['RAILS_ENV'] == 'development'
      @item = Item.new(params[:item])
      @imagefiles = params['upload']
      @msg = nil

      if !@imagefiles
            @categories = Category.find(:all)
	    @msg = 'please include an image'
            else if !@item.save
                @categories = Category.find(:all)
                render :action => 'new'
	        else
                     @imagefiles.each do |key, imagefile|
                            @image = Image.new
                            @image.file = DataFile.save(imagefile)
			    @image.item_id = @item.id
                            #debugger if ENV['RAILS_ENV'] == 'development'
                            if !@image.validate 
                                if !@image.save 
                                    @categories = Category.find(:all)
                                    @item.delete
				    else
					# everything OK to get here
					@msg = nil   
				end  #if !@image.save 
			    end  # if!@image.validate
		    end  # @imagefiles.each do
		end  # else if !@item.save
          end  # if !@imagefiles
	  if @msg 
	    render :action => 'new'
	    else
		    redirect_to :action => 'list'
	    end  #if @msg
    end  #def
    
   def edit
      @item = Item.find(params[:id])
      @categories = Category.find(:all)
   end
   def update
      @item = Item.find(params[:id])
      if @item.update_attributes(params[:item])
         redirect_to :action => 'show', :id => @item
      else
         @categories = Category.find(:all)
         render :action => 'edit'
      end
   end
   def delete 
      Image.destroy_all("item_id = '#{params[:id]}'")
      Item.find(params[:id]).destroy
      redirect_to :action => 'list'
   end
   def show_categories
      @category = Category.find(params[:id])
   end
   def show_image
#      debugger if ENV['RAILS_ENV'] == 'development'

      @image = Image.find(params[:id])
      @item = @image.item_id
   end
end

