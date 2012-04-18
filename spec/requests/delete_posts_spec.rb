require 'spec_helper'

describe "DeletePosts" do
  describe "delete /posts" do
    before(:each) do
      @post1 = Post.create(:title => "titre1", :body => "bodyyy", :creator => "Julien")
      @post2 = Post.create(:title => "titre2", :body => "bodyyy", :creator => "Julien")
    end

    it "should have links in the listing post page to delete a post" do
      visit posts_path
      page.should have_link('Destroy' , :href => post_path(@post1.id))
      page.should have_link('Destroy' , :href => post_path(@post2.id))
    end

    it "should delete a post" do
        visit posts_path
        click_link('Destroy')
        current_path.should == posts_path
        page.should have_no_content(@post1.title)
        page.should have_content(@post2.title)
    end
  end
end
