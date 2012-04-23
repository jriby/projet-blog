require 'spec_helper'

describe "DeleteComments" do
  describe "GET /delete_comments" do
    before(:each) do
      @post = Post.create(:id => 1, :title => "Titre1", :body => "I am the body")
      @comment1 = @post.comments.create(:id => 1,:author => "Julien" , :body => "I am the body of the comment1")
      @comment2 = @post.comments.create(:id => 2,:author => "Momo" , :body => "I am the body of the comment2")
    end

    it "should have links in the show post page to delete a comment" do
      visit post_path(@post)
      page.should have_link('Destroy' , :href => comment_path(@post.id,@comment1.id))
      page.should have_link('Destroy' , :href => comment_path(@post.id,@comment2.id))
    end

    it "should delete the comment" do
        visit post_path(@post)
        click_link('Destroy')
        current_path.should == post_path(@post)
        page.should have_no_content(@comment1.author)
        page.should have_no_content(@comment1.body)
        page.should have_content(@comment2.author)
        page.should have_content(@comment2.body)
    end
  end
end
