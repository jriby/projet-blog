require 'spec_helper'

describe Post do

  describe "init" do
    after do
      @p.destroy
    end
    describe "With good infos" do
      it "should be valid with a title, a body and a creator" do
        @params = { 'post' => {"title" => "title1", "body" => "I am the body of title1", "creator" => "Julien"}}
        @p = Post.create(@params['post'])
        @p.should be_valid
      end

      it "should be valid with a title, a body and without a creator" do
        @params = { 'post' => {"title" => "title1", "body" => "I am the body of title1"}}
        @p = Post.create(@params['post'])
        @p.should be_valid
      end
    end
  end

  describe "exist?" do

    it"should return true if the post exist" do
      @params = { 'post' => {"title" => "title1", "body" => "I am the body of title1", "creator" => "Julien"}}
      @p = Post.create(@params['post'])
      Post.exist?(@p.id).should == true
      @p.destroy
    end

    it"should return false if the post doesnt exist" do
      Post.exist?(666).should == false
    end

  end 

end
