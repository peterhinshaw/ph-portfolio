class FindfileController < ApplicationController
   def index
     @searchPoint = "~"
     @extensions = Extension.find(:all)
     @extension = Extension.new
   end
   def create
      @extension = Extension.new(params[:extension])
      if @extension.save
            redirect_to :action => 'list'
      else
            render :action => 'new'
      end
   end
   def delete
      Extension.find(params[:id]).destroy
      redirect_to :action => 'index'
   end
   def fileseek
      @files = Findfile.findfiles(params[:findfile][:@searchPoint], params[:extension][:selected_ids])
   end
end
