class Dealer::Users < ApplicationController
  has_many :items
  has_many :collections
  
  require_role "dealer"
  
end

def if_dealer?
  true
end

