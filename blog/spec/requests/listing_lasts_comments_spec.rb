require 'spec_helper'

describe "ListingLastsComments" do
  describe "GET /listing_lasts_comments" do
    before(:each) do
      @post1 = Post.create(:title => "sujet1", :body => "bla bla")
      @comment1 = @post1.comments.create(:author => "Julien", :body => "com1")
      @comment2 = @post1.comments.create(:author => "Momo", :body => "com2")
      @comment3 = @post1.comments.create(:author => "Momo", :body => "com3")
      @post2 = Post.create(:title => "sujet2", :body => "bla bla")
      @comment4 = @post2.comments.create(:author => "Julien", :body => "com4")
      @comment5 = @post2.comments.create(:author => "Momo", :body => "com5")
      @comment6 = @post2.comments.create(:author => "Momo", :body => "com6")

      User.stub!(:find){"Lol"}

    end
    it "generates a listing of five lasts comments" do
        visit posts_path
        page.should have_no_content @comment1.body
        page.should have_content @comment2.body
        page.should have_content @comment3.body
        page.should have_content @comment4.body
        page.should have_content @comment5.body
        page.should have_content @comment6.body
    end
    it "should have links to show linked post" do
      visit posts_path
      page.should have_link("com2...", :href => post_path(@post1.id))
      page.should have_link("com3...", :href => post_path(@post1.id))
      page.should have_link("com4...", :href => post_path(@post2.id))
      page.should have_link("com5...", :href => post_path(@post2.id))
      page.should have_link("com6...", :href => post_path(@post2.id))

    end
  end
end
