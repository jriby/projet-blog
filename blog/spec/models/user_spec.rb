require 'spec_helper'

describe User do
  describe "methode find"do

    context "With a current_user" do

      it "should return session[current_user_blog]" do
        param = {"current_user_blog" => "lol"}
        User.find(param).should == "lol"
      end      
    end

    context "Without a current_user" do

      it "should return sesson[current_user_blog] (nil)" do
        param = {"current_user_blog" => nil}
        User.find(param).should == nil
      end
    end
  end
end

