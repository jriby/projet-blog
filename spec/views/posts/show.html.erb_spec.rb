require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = stub_model(Post,:id => "1", :title => "sujet 1", :body => "lolilol")
    assign(:comments, [
      stub_model(Comment, :author => "Julien", :body => "C cool"),
      stub_model(Comment, :author => "Momo", :body => "waiii")
      ])

    assign(:post, @post)
  end
  it "displays the post and the body" do
    render
    rendered.should =~ /sujet 1/
    rendered.should =~ /lolilol/
  end
  it "displays the comment's author and the comment's body" do
    render
    rendered.should =~ /Julien/
    rendered.should =~ /C cool/
    rendered.should =~ /Momo/
    rendered.should =~ /waiii/

  end

  it "have a link Index" do
    render
    rendered.should have_link('Index', :href => posts_path)
  end
end
