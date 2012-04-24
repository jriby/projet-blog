require_relative 'spec_helper'
require 'application'
require 'user'
require 'utilisation'

describe Application do

describe "init" do

  describe "With good infos" do
    it "should be valid with a name, an url (http) and a user" do
	  @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby", "user_id" => 01}}
          @application = Application.create(@params['application'])
          @application.should be_valid
          @application.destroy
	end

    it "should be valid with a name, an url, a port, and a user" do
	  @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby:6001", "user_id" => 01}}
          @application = Application.create(@params['application'])
          @application.should be_valid
          @application.destroy
	end

    it "should be valid with a name, an url with .fr, and a user" do
      @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby.fr", "user_id" => 01}}
      @application = Application.create(@params['application'])
      @application.should be_valid
      @application.destroy
    end

  end

  describe "With info missing" do

    it "should not be valid without a name" do
      @params = { 'application' => {"url" => "http://www.julienriby", "user_id" => "01"}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:name].include?("is invalid").should be_true

    end
	
    it "should not be valid without an url" do
      @params = { 'application' => {"name" => "appli", "user_id" => 01}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:url].include?("is invalid").should be_true
          
    end

    it "should not be valid without a user_id" do
      @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby"}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:user_id].include?("can't be blank").should be_true         
    end

    it "should not be valid if the name is empty" do
      @params = { 'application' => {"name" => "", "url" => "http://www.julienriby"}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:name].include?("can't be blank").should be_true	
    end

    it "should not be valid if the url is empty" do
      @params = { 'application' => {"name" => "appli", "url" => "", "user_id" => 01}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:url].include?("can't be blank").should be_true	
    end
        
    it "should not be valid if the user_id is empty" do
      @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby", "user_id" => ""}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:user_id].include?("can't be blank").should be_true	
    end

  end

  describe "With bad info" do

    it "should not be valid with a bad url" do
      @params = { 'application' => {"name" => "appli", "url" => "bad", "user_id" => 01}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:url].include?("is invalid").should be_true
    end

    it "should not be valid with a bad name (other char than a-z0-9_-) " do
      @params = { 'application' => {"name" => "appli*bad", "url" => "bad", "user_id" => 01}}
      @application = Application.create(@params['application'])
      @application.errors.messages[:name].include?("is invalid").should be_true	
    end
  end
end

describe "Unicity" do

  it "should have a name unique" do
		
    @params1 = { 'application' => {"name" => "appli", "url" => "http://www.julienriby", "user_id" => 01}}
    @application1 = Application.create(@params1['application'])

    @params2 = { 'application' => {"name" => "appli", "url" => "http://www.julien", "user_id" => 02}}
    @application2 = Application.create(@params1['application'])

    @application2.errors.messages[:name].include?("has already been taken").should be_true	
    @application1.destroy
    @application2.destroy
  end

end



describe "Test of method delete" do
    
  it "Should delete appli and utilisations of appli" do

    @params_user1 = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
    @user1 = User.create(@params_user1['user'])

    @params_user2 = { 'user' => {"login" => "jgoin", "passwd" => "pass" }}
    @user2 = User.create(@params_user2['user'])

    @params_app = { 'application' => {"name" => "appli", "url" => "http://www.julienriby", "user_id" => @user1.id}}
    @application = Application.create(@params_app['application'])

    @params_util1 = { 'utilisation' => {"application" =>  @application, "user" => @user1}}
    @utilisation1 = Utilisation.create(@params_util1['utilisation'])

    @params_util2 = { 'utilisation' => {"application" =>  @application, "user" => @user2}}
    @utilisation2 = Utilisation.create(@params_util2['utilisation'])

    Application.delete(@application)
    Utilisation.where(:application_id => @application.id).should == []
    Application.find_by_name(@application.name).should == nil

   @user1.destroy
   @user2.destroy

  end
end

describe "Test of method present?" do
before do
  @params = { 'application' => {"name" => "appli", "url" => "http://www.julienriby", "user_id" => 01}}
end

  it "Should use find_by_name" do
    Application.should_receive(:find_by_name).with('appli')
    Application.present?('appli')
  end

  it "Should return true if the application is present" do
    @application = Application.create(@params['application'])
    Application.present?('appli').should be_true
    @application.destroy
  end

  context "will return false or unvalid"

    it "Should return false if the application is not present" do
      Application.present?('appli').should be_false
    end
 
    it "Should not be valid if the application is not given" do
      Application.present?(nil).should be_false
    end
  end
end
