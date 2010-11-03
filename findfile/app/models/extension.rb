class Extension < ActiveRecord::Base
   validates_presence_of :name
   def selected_ids 
      self.inspect
   end
end
