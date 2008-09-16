# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class MembersExtension < Radiant::Extension
  version "1.0"
  description "Extends Radiant user model for site members"
  url "http://cubiclemuses.com/cm"
  
  define_routes do |map|
     map.connect 'admin/members/profile/:action', :controller => 'admin/members/profile'
  end
  
  def activate
    admin.tabs.add "Profile", "/admin/members/profile", :after => "Layouts", :visibility => [:all]
    
    User.class_eval { 
      file_column :photo, :magick => { :geometry => "80x80>" }   
    }

  end
  
  def deactivate
    admin.tabs.remove "Profile"
  end
  
end
