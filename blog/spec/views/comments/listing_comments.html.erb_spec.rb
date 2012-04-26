require 'spec_helper'

describe "/comments/_listing_comments" do
  before(:each) do
    @p = stub_model(Post, :title => "titre1",:body => "Body")
    @c = @p.comments.create({:author => "Julien",:body => "I am the body"})
    assign(:post,@p)
  end
  it "should renders list of comments" do
    render :partial => "comments/listing_comments"
    rendered.should =~ /Julien/
    rendered.should =~ /I am the body/
  end

  context "with current user" do
    before(:each) do
      session["current_user_blog"]="Julien"
    end

    it "have a link Destroy" do
      render
      rendered.should have_link('Destroy', :"data-method" => "delete", :href => comment_path(@p.id,@c.id))
    end
  end  
  context "without current user" do
    it "not have a link Destroy" do
      render
      rendered.should_not have_link('Destroy', :"data-method" => "delete", :href => comment_path(@p.id,@c.id))
    end
  end
end
