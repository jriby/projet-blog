require 'spec_helper'

describe ApplicationController do
   describe "current_user" do
   it "should return session['current_user_blog']" do
     User.should_receive(:find)
     controller.current_user
   end
  
    context "With current user" do
      it "should return session['current_user_blog']" do
        session["current_user_blog"]="Julien"
        controller.current_user.should == "Julien"
      end
    end

    context "Without current user" do
      it "should return session['current_user_blog']" do
        controller.current_user.should == nil
      end
    end
  end
  describe "is_connected?" do
    context "Is connected" do
      it "should return true" do
        session["current_user_blog"]="Julien" 
        controller.is_connected?.should == true
      end
    end

    context "Is not connected" do
      it "should return false" do
        controller.is_connected?.should == false
      end
    end
  end
  describe "must_be_connected" do
    context "the user is not connected" do
      it "should redirect" do
        controller.should_receive(:redirect_to)
        controller.must_be_connected
      end
    end
    
    context "the user is connected" do
      before(:each) do
        session["current_user_blog"]="Julien"
      end
      it "should have respinse status 200" do
        controller.must_be_connected
        response.status.should == 200
      end
    end
  end

end
