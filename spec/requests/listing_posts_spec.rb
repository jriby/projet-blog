require 'spec_helper'

describe "ListingPosts" do
  describe "GET /posts" do
    before(:each) do
      @post1 = Post.create(:title => "sujet1", :body => "bla bla", :creator => "jriby")
      @post2 = Post.create(:title => "sujet2", :body => "bla bla", :creator => "jriby")
    end

    describe "GET /posts" do
      it "generates a listing of posts" do
        visit posts_path
        page.should have_content @post1.title
        page.should have_content @post2.title
      end
    end
  end
end
