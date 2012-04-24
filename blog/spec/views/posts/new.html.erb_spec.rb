require 'spec_helper'

describe "posts/new" do
  it "renders new post form" do
    render
    rendered.should =~ /New post/
    rendered.should have_selector("form[action='/posts']")
    rendered.should have_selector("input[name='post[title]']")
    rendered.should have_content('title')
    rendered.should have_selector("textarea[name='post[body]']")
    rendered.should have_content('body')
    rendered.should have_selector("input[type='submit']")
  end
end
