require 'spec_helper'

describe User do
  describe "methode find"do

    context "With a current_user" do

      it "should return sesson[current_user_blog]" do
        #session["current_user_blog"] = "lol"
        #User.find(session).should == "lol"
      end      
    end

    context "With a current_user" do

      it "should return sesson[current_user_blog]" do
                #User.find(session).should == nil
      end
    end
  end
end
