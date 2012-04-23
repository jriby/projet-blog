require 'spec_helper'

describe "ListingComments" do
  describe "GET /posts/:id" do
    before(:each) do
      @post = Post.create(:title => "sujet1", :body => "bla bla")
      @comment1 = @post.comments.create(:author => "Julien", :body => "bla bla")
      @comment2 = @post.comments.create(:author => "Momo", :body => "bla bla")
    end
      it "generates a listing of comments" do
        visit post_path(@post)
        page.should have_content @comment1.author
        page.should have_content @comment1.body
        page.should have_content @comment2.author
        page.should have_content @comment2.body
      end
  end
end
