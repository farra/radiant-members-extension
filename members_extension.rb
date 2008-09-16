# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class MembersExtension < Radiant::Extension
  version "1.0"
  description "Extends Radiant user model for site members"
  url "http://cubiclemuses.com/cm"
  
  define_routes do |map|
     map.connect 'admin/members/register/:action', :controller => 'admin/members/register'        
     map.connect 'admin/members/:action', :controller => 'admin/members/profile'
  end
  
  def activate
    admin.tabs.add "Profile", "/admin/members/", :after => "Layouts", :visibility => [:all]
    
    User.class_eval do
      file_column :photo, :magick => { :geometry => "80x80>" }   
      validates_presence_of :email, :message => 'required'      
    end

    Radiant::AdminUI::Tab.class_eval do

      alias_method :initialize_less_securely, :initialize unless method_defined?(:initialize_more_securely)
      
      def initialize_more_securely(name, url, options = {})
        @name, @url = name, url
        @visibility = [options[:for], options[:visibility]].flatten.compact
        @visibility = [:developer,:admin] if @visibility.empty?
      end      
      
      alias_method :initialize, :initialize_more_securely      
      
    end
    
    Admin::PageController.class_eval do 
      only_allow_access_to :index, :new, :edit, :remove,
        :when => [:developer, :admin],
        :denied_url => { :controller => 'welcome', :action => 'index' },
        :denied_message => 'You must have developer privileges to perform this action.'        
    end
    
    Admin::SnippetController.class_eval do 
      only_allow_access_to :index, :new, :edit, :remove,
        :when => [:developer, :admin],
        :denied_url => { :controller => 'welcome', :action => 'index' },
        :denied_message => 'You must have developer privileges to perform this action.'        
    end    
    
    Admin::WelcomeController.class_eval do 
      alias_method :index_to_page, :index unless method_defined?(:index_to_profile)
      
      def index_to_profile
        redirect_to :controller => 'admin/members/profile', :action => 'index'
      end
      
      alias_method :index, :index_to_profile      
    end    
    
    
  end
  
  def deactivate
    admin.tabs.remove "Profile"
  end
  
end
