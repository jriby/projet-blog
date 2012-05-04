require 'spec_helper'

describe "DeleteSessions" do
  describe "delete /session" do
    before(:each) do
      User.stub!(:find){"Lol"}
    end

    it "should have a link in the listing post page to disconnect" do
      visit posts_path
      page.should have_link('Disconnect', :href => session_path)
    end

    it "should disconnnect the user" do
        User.stub!(:find){"Lol"}
        visit posts_path
        page.should have_content('Connected')
        User.stub!(:find){nil}
        click_link('Disconnect')
        current_path.should == posts_path
        page.should have_content("Not connected")
    end      
  end
end
