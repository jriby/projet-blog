require 'spec_helper'

describe "comments/new" do
  before(:each) do
    @p=stub_model(Post, :title => "Titre1",:body => "Body")
    assign(:post,@p)
  end
  it "renders new comment form" do
    render
    rendered.should have_selector("form[action='/posts/#{@p.id}/comments']")
    rendered.should have_selector("input[name='comment[author]']")
    rendered.should have_selector("textarea[name='comment[body]']")
    rendered.should have_selector("input[type='submit']")
  end
end
