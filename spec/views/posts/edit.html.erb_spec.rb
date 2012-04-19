require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = stub_model(Post,:id => "1", :title => "Titre1", :body => "body1")
    assign(:post, @post)
  end
  it "renders new post form" do
    render
    rendered.should =~ /Edit post page/
    rendered.should have_selector("form[action='/posts/#{@post.id}']")
    rendered.should have_selector("input[name='post[title]']")
    rendered.should have_content('title')
    rendered.should have_selector("textarea[name='post[body]']")
    rendered.should have_content('body')
    rendered.should have_selector("input[type='submit']")
  end
end
