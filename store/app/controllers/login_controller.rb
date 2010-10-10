class LoginController < ApplicationController
#  model   :user
#  layout  'scaffold'

#  layout "admin"
  def add_user
    if request.get?
      @user = User.new
    else
      @user = User.new(params[:user])
      if @user.save
         redirect_to_index("User #{@user.name} created")
      end
    end
  end

  def login
#    debugger if ENV['RAILS_ENV'] == 'development'
    if request.get?
        session[:user_id] = nil
        @user = User.new
    else
        @user = User.new(params[:user])
        logged_in_user = @user.try_to_login
        if logged_in_user
            session[:user_id] = logged_in_user.id
            redirect_to_index
        else
          flash.now[:notice]  = "invalid login parameters"
      end
    end
  end
  
  def signup
    case @request.method
      when :post
        @user = User.new(@params['user'])
        
        if @user.save      
          @session['user'] = User.authenticate(@user.name, @params['user']['password'])
          flash['notice']  = "Signup successful"
          redirect_back_or_default :action => "welcome"          
        end
      when :get
        @user = User.new
    end      
  end  
  
  def delete
    if @params['id'] and @session['user']
      @user = User.find(@params['id'])
      @user.destroy
    end
    redirect_back_or_default :action => "welcome"
  end  
    
  def logout
    @session['user'] = nil
  end
    
  def welcome
  end
  
end
