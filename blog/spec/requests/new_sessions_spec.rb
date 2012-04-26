require 'spec_helper'
require 'capybara/mechanize'

describe "NewSessions", :driver => :mechanize do
  describe "GET /sessions/new" do

    it "should have a link in the listing post page to signin" do
      visit posts_path
      page.should have_link('Connection', :href => new_session_path)
    end

    it "should redirect to the sauth" do
      visit posts_path
      click_link('Connection')
      current_path.should == "/sessions/new/app/app_blog"
      page.should have_content('Portail de Connexion')
      page.should have_selector('form')
    end

    it "should connect you to the blog" do
      visit posts_path
      click_link('Connection')
      fill_in('login', :with => 'Julien')
      fill_in('passwd', :with => 'lol')
      click_button('Se connecter')
      current_path.should == posts_path
      page.should have_content('Julien')
    end
  end
end
