class Item < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :category
  belongs_to :collection
  validates_presence_of :title, :message => " is required"
  validates_presence_of :description, :message => " is required"
  validates_numericality_of :price, :message=>" must be numeric"
  validates_numericality_of :shipping, :message=>" must be numeric"
  validates_inclusion_of :quantity, :in => 0..999, :message => " must a whole number from 0 to 999"
  validates_length_of :title, :maximum=>32, :message => " can only accept 32 characters"
  validates_uniqueness_of :title

  has_many :images

  def self.title_search(search)
    if search
      find(:all, :conditions => { :title => "%#{search}%", :quantity => 1 })
    else
      find(:all)
    end
  end

  def self.description_search(search)
    if search
	one=1
	find(:all, :conditions => ['description LIKE ? AND quantity > 0', "%#{search}%"])
    else
      find(:all, :conditions => 'quantity > 0')
    end
  end 
  def self.find_products_for_sale
    find(:all, :order => "title")
  end

  def decrement_quantity(value=nil)
	  if !value
		  value = 1
	  end
	  self.quantity = self.quantity - value
	  self.save!
  end
  def increment_quantity(value=nil)
	  if !value
		  value = 1
	  end
	  self.quantity = self.quantity + value
	  self.save!
  end

  protected

  def validate
    errors.add(:price, "should be at least 0.01") if price.nil? ||  price < 0.01
    errors.add(:shipping, "should be at least 0.01") if shipping.nil? ||  shipping < 0.01
    errors.add(:quantity, "should be at least 0") if quantity.nil? ||  quantity < 0.00
  end
end
