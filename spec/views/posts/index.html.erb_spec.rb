require 'spec_helper'

describe "posts/index.html.erb" do
    before(:each) do
          assign(:posts, [
           stub_model(Post, :id => "1", :title => "sujet 1"),
           stub_model(Post, :id => "2", :title => "sujet 2")
          ])
    end

  it "displays all the posts" do
    render
    rendered.should =~ /sujet 1/
    rendered.should =~ /sujet 2/
  end

  it "have a link New Post" do
    render
    rendered.should have_link('New Post', :href => new_post_path)
  end


  it "have a link Destroy" do
    render
    rendered.should have_link('Destroy', :"data-method" => "delete", :href => post_path(1))
    rendered.should have_link('Destroy', :"data-method" => "delete", :href => post_path(2))
  end

end
