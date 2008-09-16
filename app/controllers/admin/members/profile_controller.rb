class Admin::Members::ProfileController < ApplicationController
      
  def index
    @current_user = current_user
    snippet = Snippet.find_by_name 'profile_sidebar'
    if snippet
      #TODO a bit a hack here to render the snippet in the context
      #     of the first page.  Is there a better way to render a snippet like this?
      p = Page.find(:all).first
      @sidebar_text = p.render_snippet snippet
    end
  end
  
  def edit
    if params[:user][:password] != nil && params[:user][:password].size > 0
      current_user.update_attributes(params[:user])      
    end
    if params[:person][:id].size > 0
      person = Person.find(params[:person][:id])
      person.update_attributes(params[:person])
    else
      person = Person.new(params[:person])
      person.user = current_user
      current_user.person = person      
    end    
    person.save!
    redirect_to :action => 'index'
  end  
  
end
