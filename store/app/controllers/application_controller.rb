# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to(:controller => 'store', :action => 'index')
  end
end
