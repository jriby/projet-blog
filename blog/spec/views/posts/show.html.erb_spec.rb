require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = stub_model(Post,:id => "1", :title => "sujet 1", :body => "lolilol")
    assign(:post, @post)
  end
  it "displays the post and the body" do
    render
    rendered.should =~ /sujet 1/
    rendered.should =~ /lolilol/
  end

  it "displays comments" do
   render
   view.should render_template(:partial => "_listing_comments")
  end
end
