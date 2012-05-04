require 'spec_helper'

describe "CreatePosts" do
  before(:each) do
    User.stub!(:find){"Lol"}
  end

  describe "GET /posts/new" do
    it "should have a link in the listing post page to create a post" do
      visit posts_path
      page.should have_link('New Post' , :href => new_post_path)
    end
    
    it "should print the form to create a new post" do
      visit posts_path
      click_link('New Post')
      page.should have_content('New post')
      page.should have_selector('form')
    end
  end

  describe "POST /posts" do   
    it "should create the post and print the posts" do
      visit new_post_path
      fill_in('post[title]', :with => 'title1')
      fill_in('post[body]', :with => 'body1')
      click_button('Create')
      current_path.should == posts_path
      page.should have_content('title1')
    end
  end
end
