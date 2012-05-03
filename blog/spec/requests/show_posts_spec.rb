require 'spec_helper'

describe "ShowPosts" do
  describe "show" do
    before(:each) do
      @post = Post.create(:title => "sujet1", :body => "bla bla", :creator => "jriby")
    end
   it "should have a link in the listing post page to show a post" do
      visit posts_path
      page.should have_link('Show' , :href => post_path(@post))
    end
    

    it "print the title and the body of the post" do
      visit post_path(@post)
      current_path.should == post_path(@post)
      page.should have_content @post.title
      page.should have_content @post.body
    end

  end
end
