require 'spec_helper'

describe "_status_session" do
    
    context "with current user" do

      before(:each) do
        view.stub(:is_connected?){true}
        view.stub(:current_user){"lol"}

      end

      it "should displays Connected with the login" do
        view.stub(:current_user){"Login"}
        render :partial => "sessions/status_session"
        rendered.should =~ /Connected/
        rendered.should =~ /Login/
      end
      it "should displays Connected with the login" do
        view.stub(:current_user){"Login"}
        render :partial => "sessions/status_session"
        rendered.should =~ /Connected/
        rendered.should =~ /Login/
      end
      it "have a link Disconnect" do
        render :partial => "sessions/status_session"
        rendered.should have_link('Disconnect')
      end
    end
    context "without current user" do
      before(:each) do
        view.stub(:is_connected?){false}
      end
      it "should displays Not Connected" do
        render :partial => "sessions/status_session"
        rendered.should =~ /Not connected/
      end
      it "have a link Connection" do
        render :partial => "sessions/status_session"
        rendered.should have_link('Connection', :href => new_session_path)
      end

    end

end
