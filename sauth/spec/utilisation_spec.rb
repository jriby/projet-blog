require_relative 'spec_helper'
require 'application'
require 'user'
require 'utilisation'

describe Utilisation do
    before do
        @params_user = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
	@params_app = { 'application' => {"name" => "appli", "url" => "http://www.julienriby.fr", "user_id" => 01}}
    end

  describe "With good infos" do

	it "should be valid with an application and a user" do
          @application = Application.create(@params_app['application'])
          @user = User.create(@params_user['user'])

          @params_util = { 'utilisation' => {"application" =>  @application, "user" => @user}}
          @utilisation = Utilisation.create(@params_util['utilisation'])

          @utilisation.should be_valid

          @utilisation.destroy
          @application.destroy
          @user.destroy
        end

  end

  describe "With info missing" do

	it "should not be valid without an application" do
          
          @user = User.create(@params_user['user'])

          @params_util = { 'utilisation' => {"user" => @user}}
          @utilisation = Utilisation.create(@params_util['utilisation'])

          @utilisation.should_not be_valid

          @user.destroy

        end
	it "should not be valid without a user" do
        
          @application = Application.create(@params_app['application'])

          @params_util = { 'utilisation' => {"application" =>  @application}}
          @utilisation = Utilisation.create(@params_util['utilisation'])

          @utilisation.should_not be_valid

          @application.destroy

        end

  end

  describe "Test de is_present" do
    before do
        @params_user = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
	@params_app = { 'application' => {"name" => "appli", "url" => "http://www.julienriby.fr", "user_id" => 01}}
    end
    

    it "Should return true if the utilisation is present" do

        @application = Application.create(@params_app['application'])
        @user = User.create(@params_user['user'])

        @params_util = { 'utilisation' => {"application" =>  @application, "user" => @user}}
        @utilisation = Utilisation.create(@params_util['utilisation'])

        Utilisation.present?(@user, @application).should be_true
        @utilisation.destroy
        @application.destroy
        @user.destroy

    end



    context "will return false" do
    before do
      @params_user = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
      @params_app = { 'application' => {"name" => "appli", "url" => "http://www.julienriby.fr", "user_id" => 01}}
      @application = Application.create(@params_app['application'])
      @user = User.create(@params_user['user'])
    end
    after do
      @application.destroy
      @user.destroy
    end
      it "Should return false if the utilisation is not present" do
        Utilisation.present?(@user, @application).should be_false
    end
 
      it "Should not be valid if the user is not given" do
        Utilisation.present?(nil, @application).should be_false
      end

      it "Should not be valid if the application is not given" do
        Utilisation.present?(@user, nil).should be_false
      end

      it "Should not be valid if the login and the application is not given" do
        Utilisation.present?(nil, nil).should be_false 
      end


  end

  end

end
