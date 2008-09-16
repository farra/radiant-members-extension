class CreateProfileSnippet < ActiveRecord::Migration
  
  def self.up
    snippet = Snippet.new
    snippet.name = "profile_sidebar"
    snippet.content = " "
    snippet.save!
  end

  def self.down
    snippet = Snippet.find_by_name 'profile_sidebar'
    snippet.delete
  end
  
end
