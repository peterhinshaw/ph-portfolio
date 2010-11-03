class Recommendation < ActiveRecord::Base
  attr_accessible :from_email, :to_email, :article_id, :message
end
