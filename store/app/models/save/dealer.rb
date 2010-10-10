class Dealer < ActiveRecord::Base
  has_many :items
  has_many :collections
end
