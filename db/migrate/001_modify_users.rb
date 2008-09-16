class ModifyUsers < ActiveRecord::Migration
  
  def self.up
    add_column :users, :photo, :string
    add_column :users, :url, :string    
  end

  def self.down
    remove_column :users, :photo
    remove_column :users, :url
  end
  
end
