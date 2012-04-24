require 'spec_helper'

describe "_status_session" do
    
    context "with current user" do
      it "should displays Connected with the login" do
        session["current_user_blog"] = "Login"
        render :partial => "sessions/status_session"
        rendered.should =~ /Connected/
        rendered.should =~ /Login/
      end
    end
    context "without current user" do
      it "should displays Not Connected" do
        render :partial => "sessions/status_session"
        rendered.should =~ /Not connected/
      end
    end

end
