require 'spec_helper'

  include SessionsHelper

describe "EditPosts" do
  before(:each) do
    @post = Post.create(:title => "Titre1", :body => "body1", :creator => "Julien")
    User.stub!(:find){"Lol"}
  end

    it "should have a link in the listing post page to edit a post" do
      visit posts_path
      page.should have_link('Edit', :href => edit_post_path(@post))
    end

    it "should print the form to edit a new post" do
      visit edit_post_path(@post)
      page.should have_content('Edit post page')
      page.should have_selector('form')
    end

    it "should update the post and print the posts" do
      visit edit_post_path(@post)
      fill_in('post[title]', :with => 'title2')
      fill_in('post[body]', :with => 'body2')
      click_button('Update')
      current_path.should == posts_path
      page.should have_content('title2')
      page.should have_no_content('title1')
    end
end
