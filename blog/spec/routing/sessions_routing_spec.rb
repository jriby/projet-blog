require 'spec_helper'
describe SessionsController do 

  it "routes to #new" do 
    get('/sessions/new').should route_to("sessions#new")
  end

   it "should provide the aliast new_session_path for /session/new" do 
    new_session_path.should == '/sessions/new'
  end

  it "should provide the aliast session_path for /sessions" do
    session_path.should == '/sessions'
  end

    it "routes to #destroy" do 
    delete('/sessions').should route_to("sessions#destroy")
  end



end
