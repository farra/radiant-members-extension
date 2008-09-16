class Admin::Members::RegisterController  <  Admin::AbstractModelController
  model_class User
  
  no_login_required
  skip_before_filter :verify_authenticity_token 
  
  
  def index
    self.model = model_class.new
    render :action => 'index', :layout => nil
  end
  
  def new
    self.model = model_class.new
    handle_new_or_edit_post    
  end
  
  def continue_url(options)
    return { :controller => 'admin/members/profile', :action => 'index' }
  end  
   
  
end
