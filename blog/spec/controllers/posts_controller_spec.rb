require 'spec_helper'
describe PostsController do
  describe "GET 'index'" do
    before(:each) do
      @posts = [stub_model(Post,:title => "1"), stub_model(Post, :title => "2")]
      Post.stub(:all){ @posts }
    end
    it "should not use must_be_connected" do
      controller.should_not_receive(:must_be_connected)
      get 'index'
    end
    it "assigns a list of posts" do
      Post.should_receive(:all).and_return(@posts)
      get 'index'
      assigns(:posts).should eq @posts
      response.should be_success
    end

    it "renders the template list" do
      get 'index'
      response.should render_template(:index)
    end
  end

  describe "GET 'new'" do
    before(:each) do
      session["current_user_blog"]="Julien"
    end
    it "should use must_be_connected" do
      controller.should_receive(:must_be_connected)
      get 'new',@params
    end
    it "should use new" do
      Post.should_receive(:new)
      get 'new'
      response.should be_success
    end

    it "renders the template new" do
      get 'new'
      response.should render_template(:new)
    end
  end
  describe "POST '/posts'" do
   before(:each) do
      session["current_user_blog"]="Julien"
      @p = double(Post)
      Post.stub(:create){@p}
      @params={:post=>{:title=>"title",:body=>"content"}}
    end

    it "should use must_be_connected" do
      controller.should_receive(:must_be_connected)
      post 'create',@params
    end

    it "should create a new post" do
      Post.should_receive(:create).with("title"=>"title", "body"=>"content")
      post 'create',@params
    end
    
    it "should redirect to the posts page" do
       post 'create',@params
       response.should redirect_to(posts_path)
    end
  end

  describe "DELETE '/posts/:id'" do
   before(:each) do
      session["current_user_blog"]="Julien"
      @p = double(Post)
      Post.stub(:find_by_id){@p}
      @p.stub(:destroy)
      @params={:id =>"1"}
    end
    it "should use post_exist" do
      controller.should_receive(:post_exist)
      delete 'destroy',@params
    end

    it "should use must_be_connected" do
      controller.should_receive(:must_be_connected)
      delete 'destroy',@params
    end

    it "should use find and return the post" do
      Post.should_receive(:find_by_id).with("1")
      delete 'destroy',@params 
    end

    it "should use destroy the post" do
      @p.should_receive(:destroy)
      delete 'destroy',@params
    end

    it "should redirect to the posts page" do
       delete 'destroy',@params
       response.should redirect_to(posts_path)
    end
  end
  describe "GET '/posts/:id/edit'" do
   before(:each) do
      session["current_user_blog"]="Julien"
      @p = double(Post)
      Post.stub(:find_by_id){@p}
      @params={:id =>"1"}
    end

    it "should use post_exist" do
      controller.should_receive(:post_exist)
      get 'edit',@params
    end

    it "should use must_be_connected" do
      controller.should_receive(:must_be_connected)
      get 'edit',@params
    end

    it "should use find" do
      Post.should_receive(:find_by_id).with("1")
      get 'edit',@params
      response.should be_success
    end

    it "renders the template edit" do
      get 'edit',@params
      response.should render_template(:edit)
    end
  end

  describe "PUT '/posts/:id'" do
   before(:each) do
      session["current_user_blog"]="Julien"
      @p = double(Post)
      Post.stub(:find_by_id){@p}
      @p.stub(:update_attributes)
      @params={:id=>1,:post=>{"title"=>"title2","body"=>"body2"}}
    end

    it "should use post_exist" do
      controller.should_receive(:post_exist)
      put 'update',@params
    end

    it "should use must_be_connected" do
      controller.should_receive(:must_be_connected)
      put 'update',@params
    end
    it "should use find" do
      Post.should_receive(:find_by_id).with("1")
      put 'update',@params
    end
    it "should use update_atttributes" do
      @p.should_receive(:update_attributes).with(@params[:post])
      put 'update',@params
    end
    it "redirect to the post page" do
      put 'update',@params
      response.should redirect_to(posts_path)
    end
  end

  describe "GET '/posts/:id'" do
   before(:each) do
      @p = double(Post)
      Post.stub(:find_by_id){@p}
      @params={:id =>"1"}
    end

    it "should use post_exist" do
      controller.should_receive(:post_exist)
      get 'show',@params
    end

    it "should use find" do
      Post.should_receive(:find_by_id).with("1")
      get 'show',@params
      response.should be_success
    end

    it "renders the template show" do
      get 'show',@params
      response.should render_template(:show)
    end
  end

end
