require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do

    context "Without session" do
      it "should redirect to the sauth" do
        get 'new'
        response.should redirect_to('http://sauth:6666/sessions/new/app/app_blog?origin=/sessions/new')
      end

      context "Response of sauth" do
        before do
          @params = { 'secret' => "jesuisauth", "login" => "log"}
        end

          it "should redirect to the posts_path" do
            get 'new', @params
            response.should redirect_to(posts_path)
          end
        it "should set the session" do
          get 'new', @params
          request.env["rack.session"]["current_user_blog"].should == "log"
        end
      end
    end
    context "With session" do
      it "should redirect to the posts_path" do
        request.env["rack.session"]["current_user_blog"] = "log"
        get 'new'
        response.should redirect_to(posts_path)
      end
    end 

    context "Bad secret" do
      it "should redirect to 403" do
        @params = { 'secret' => "jenesuispasauth", "login" => "log"}
        get 'new', @params
        response.status.should == 403
      end
    end
  end
end
