require 'digest/sha1' 

class User < ActiveRecord::Base

attr_accessor :password

def self.login(name, password)
  password = hash_password(password || "")
  find(:first,
       :conditions => ["name = ? and password = ?",
                        name, password])
end

def try_to_login
  User.login(self.name, self.password) ||
  User.find_by_name_and_password(name, "")
end

def before_create
  self.password = User.hash_password(self.password)
end

def after_create
  @password = nil
end

def self.authenticate(name, pass)
  find_first(["name = ? AND password = ?", name, sha1(pass)])
end

def change_password(pass)
  update_attribute "password", self.class.sha1(pass)
end

protected

def self.hash_password(pass)
  Digest::SHA1.hexdigest("change-me--#{pass}--")
end

before_create :crypt_password

def crypt_password
  write_attribute("password", self.class.hash_password(password))
end

validates_length_of :name, :within => 3..40
validates_length_of :password, :within => 5..40
validates_presence_of :name, :password, :password_confirmation
validates_uniqueness_of :name, :on => :create
validates_confirmation_of :password, :on => :create

end
