require 'spec_helper'
describe PostsController do 
  it "routes to #index with /posts" do 
    get('/posts').should route_to("posts#index")
  end

  it "routes to #index with /" do 
    get('/').should route_to("posts#index")
  end

  it "should provide the aliast post_path for /posts" do 
    posts_path.should == '/posts'
  end

   it "routes to #new" do 
    get('/posts/new').should route_to("posts#new")
  end

  it "should provide the aliast new_post_path for /posts/new" do
    new_post_path.should == '/posts/new'
  end

  it "should routes to #create" do
    post('/posts').should route_to("posts#create")
  end

  it "routes to #destroy" do 
    delete('/posts/1').should route_to("posts#destroy", :id => "1")
  end

  it "should routes to #edit" do
    get('/posts/1/edit').should route_to("posts#edit", :id => "1")
  end

  it "should routes to #update" do
    put('/posts/1').should route_to("posts#update", :id => "1")
  end

  it "should routes to #show" do
    get('/posts/1').should route_to("posts#show", :id => "1")
  end

end
