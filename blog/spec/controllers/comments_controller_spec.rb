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

  describe "DELETE '/posts/:post_id/comments/:id'" do
   before(:each) do
      session["current_user_blog"]="Julien"
      @p = double(Post)
      @c=double(Comment)
      Post.stub(:find_by_id){@p}
      @p.stub(:comments){@c}
      @c.stub(:find){@c}
      @c.stub(:destroy)
      @params={:id=>1, :post_id=>1}
    end
    it "should not use must_be_connected" do
      controller.should_receive(:must_be_connected)
      delete 'destroy',@params
    end
    it "should use find_by_id and return the post" do
      Post.should_receive(:find_by_id).with("1")
      delete 'destroy',@params
    end
    it "should use find and return the comment" do
      @p.should_receive(:comments)
      @c.should_receive(:find).with("1")
      delete 'destroy',@params
    end

    it "should use destroy the comment" do
      @c.should_receive(:destroy)
      delete 'destroy',@params
    end

    it "should redirect to the post page" do
       delete 'destroy',@params
       response.should redirect_to(post_path(@p))
    end
  end


end
