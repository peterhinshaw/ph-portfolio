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
# Table name: products
#
#  id          :integer(11)   not null, primary key
#  title       :string(255)   
#  description :text          
#  image_url   :string(255)   
#  price       :integer(11)   default(0)
#


class Product < ActiveRecord::Base

  has_many :orders, :through => :line_items

  has_many :line_items
  
  def self.find_products_for_sale
    find(:all, :order => "title")
  end
  

  
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validates_uniqueness_of :title
  validates_format_of :image_url, 
                      :with    => %r{\.(gif|jpg|png)$}i,
                      :message => "must be a URL for a GIF, JPG, or PNG image"
  protected

  def validate
    errors.add(:price, "should be at least 0.01") if price.nil? ||  price < 0.01
  end
  

end


