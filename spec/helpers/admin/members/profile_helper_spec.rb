require File.dirname(__FILE__) + '/../../../spec_helper'

describe Admin::Members::ProfileHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should include the Admin::Members::ProfileHelper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(Admin::Members::ProfileHelper)
  end
  
end
