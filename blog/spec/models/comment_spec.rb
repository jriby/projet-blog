require 'spec_helper'

describe Comment do
  describe "init" do
    after do
      @c.destroy
    end
    describe "With good infos" do
      it "should be valid with a title, a body and a creator" do
        @params = { 'comment' => {"author" => "Julien", "body" => "I am the comment", "post_id" => 1}}
        @c = Comment.create(@params['comment'])
        @c.should be_valid
      end
      it "should not be valid without a post_id" do
        @params = { 'comment' => {"author" => "Julien", "body" => "I am the comment"}}
        @c = Comment.create(@params['comment'])
        @c.should_not be_valid
      end

    end
  end

end
