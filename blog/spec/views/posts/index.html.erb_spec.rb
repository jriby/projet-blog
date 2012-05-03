require 'spec_helper'

describe "posts/index" do
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

  context "with current user" do
    before(:each) do
      session["current_user_blog"]="Julien"
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
    it "have a link Edit" do
      render
      rendered.should have_link('Edit')
    end
  end
  context "without current user" do
    
    it "not have a link New Post" do
      render
      rendered.should_not have_link('New Post')
    end

    it "not have a link Destroy" do
      render
      rendered.should_not have_link('Destroy')
    end
    it "not have a link Edit" do
      render
      rendered.should_not have_link('Edit')
    end
  end
end
