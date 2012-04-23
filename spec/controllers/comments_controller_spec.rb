require 'spec_helper'

describe CommentsController do

  describe "GET 'new'" do
   before(:each) do
      @p = double(Post)
      Post.stub(:find_by_id){@p}
      @params={:post_id=> 1}
    end

    it "should use new" do
      Post.should_receive(:find_by_id).with("1")
      get 'new', @params
      response.should be_success
    end

    it "renders the template new" do
      get 'new', @params
      response.should render_template(:new)
    end
  end
  describe "POST 'create'" do
   before(:each) do
      @p = double(Post)
      @c=double(Comment)
      Post.stub(:find_by_id){@p}
      @p.stub(:comments){@c}
      @c.stub(:create)
      @params={:post_id=> 1, :comment=>{"author"=>"Author","body"=>"Body"}}
    end

    it "should receive find_by_id" do
      Post.should_receive(:find_by_id).with("1")
      post 'create',@params
    end
    it "should create a new comment" do
      @c.should_receive(:create).with("author"=>"Author","body"=>"Body")
      post 'create',@params
    end
    it "should redirect to the posts page" do
       post 'create',@params
       response.should redirect_to(post_path(@p))
    end
  end


end
