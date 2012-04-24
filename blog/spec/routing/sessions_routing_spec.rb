require 'spec_helper'
describe SessionsController do 

  it "routes to #new" do 
    get('/sessions/new').should route_to("sessions#new")
  end

   it "should provide the aliast new_session_path for /session/new" do 
    new_session_path.should == '/sessions/new'
  end

  it "routes to the sauth" do 
    #get('http://sauth:6666/sessions/new/app/app_blog?origin=/sessions/new').should redirect_to("http://sauth:6666/sessions/new/app/app_blog?origin=/sessions/new")
  end


end
