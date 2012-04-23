require 'spec_helper'
describe CommentsController do 
  it "routes to #new" do 
    get('/posts/1/comments/new').should route_to("comments#new", :post_id => "1")
  end

  it "routes to #create" do 
    post('/posts/1/comments').should route_to("comments#create", :post_id => "1")
  end

end
