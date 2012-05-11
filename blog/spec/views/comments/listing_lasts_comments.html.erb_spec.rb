describe "/comments/_lasts_comments" do
  before(:each) do
    @p = Post.create(:title => "lool")
    @p.comments.create(:author => "coucou1" , :body => "com1")
    @p.comments.create(:author => "coucou2" , :body => "com2")
    @p.comments.create(:author => "coucou3" , :body => "com3")
    @p.comments.create(:author => "coucou4" , :body => "com4")
    @p.comments.create(:author => "coucou5" , :body => "com5")
    @p.comments.create(:author => "coucou6" , :body => "com6")
  end
  it "should renders title of the five lastes post" do
    render :partial => "comments/listing_lasts_comments"
    rendered.should =~ /com6/
    rendered.should =~ /com5/
    rendered.should =~ /com4/
    rendered.should =~ /com3/
    rendered.should =~ /com2/
    rendered.should_not =~ /com1/
  end
end
