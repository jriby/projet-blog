require 'spec_helper'

describe "CreateComments" do
  before(:each) do
     @post = Post.create(:title => "Titre1", :body => "I am the body")
  end
  describe "GET /posts/:id" do

    it "should have a link in show post page to create a comment" do
      visit post_path(@post)
      page.should have_link('Add a comment' , :href => new_comment_path(@post))
    end

    it "should print the form to create a comment" do
      visit new_comment_path(@post)
      page.should have_selector('form')
      page.should have_content('Author')
      page.should have_field('comment[author]')
      page.should have_content('body')
      page.should have_field('comment[body]')
    end
  end

  describe "POST /posts/:id/comments" do
    it "should create the comment and print the comment" do
      visit new_comment_path(@post)
      fill_in('comment[author]', :with => 'I am the author')
      fill_in('comment[body]', :with => 'I am the body of the comment')
      click_button('Submit Comment')
      current_path.should == post_path(@post)
      page.should have_content('I am the author')
      page.should have_content('I am the body of the comment')
    end
  end
end
