# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

load 'calculator/vintagesales_standard_calculator.rb'
load 'calculator/vintagesales_priority_calculator.rb'
load 'calculator/vintagesales_overnight_calculator.rb'


class VintagesalesExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/vintagesales"

  # Please use vintagesales/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
      puts "Activating VintageSalesExtension"
      [
      Calculator::VintageSalesPriorityCalculator,
      Calculator::VintageSalesOvernightCalculator,
      Calculator::VintageSalesStandardCalculator,
      ].each(&:register) 
      AppConfiguration.class_eval do 
        preference :stylesheets, :string, :default => 'compiled/screen,vintagesales' 
        preference :logo, :string, :default => '/images/logo.png'      
      end 


    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
