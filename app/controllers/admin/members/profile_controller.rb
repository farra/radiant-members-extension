class Admin::Members::ProfileController <  Admin::AbstractModelController
  model_class User

  login_required
 
      
  def index
    @sidebar_text = ''
    @user = current_user
    snippet = Snippet.find_by_name 'profile_sidebar'
    if snippet
      #TODO a bit a hack here to render the snippet in the context
      #     of the first page.  Is there a better way to render a snippet like this?
      p = Page.find(:all).first
      @sidebar_text = p.render_snippet snippet if p
    end
  end
  
  def edit
  # let's only allow editing the current user...
  # self.model = model_class.find_by_id(params[:user][:id])
    self.model = current_user
    handle_new_or_edit_post
  end  
  
  def continue_url(options)
    return { :controller => 'admin/members/profile', :action => 'index' }
  end

  
end
