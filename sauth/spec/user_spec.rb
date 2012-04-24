require_relative 'spec_helper'
require 'user'



describe User do

#Une personne doit être valide si elle dispose d'un nom et d'un prénom. Le login d'une personne doit être unique sur toute la base.

before(:each) do
	@u=User.new()
end

context "init" do

  describe "With info not missing" do


        it "should be valid with a login a passwd" do

		@u.login = "jfunt"
		@u.passwd = "pass"
		@u.should be_valid

	end

  describe "With info missing" do
  before do
    @u.login = "jriby"
    @u.passwd = "pass"
  end
	it "should not be valid without a passwd" do
				
		@u.passwd = nil	
		@u.should_not be_valid
	end
	
	it "should not be valid without a login" do

		@u.login = nil
		@u.should_not be_valid
	end

        it "should not be valid if the login is empty" do
		@u.login = ""			
		@u.should_not be_valid
	end

        it "should not be valid if the passwd is empty" do
		@u.passwd = ""			
		@u.should_not be_valid
	end

  end
        
  end

  describe "Unicity" do

	it "should have a login unique" do
		
		@u1=User.new()
		@u2=User.new()
		@u1.login = "jgoin"
		@u1.passwd = "pass"	
		@u1.save
	
		@u2.login = "jgoin"
		@u2.passwd = "pass1"
		@u2.valid?
		@u2.errors.messages[:login].include?("has already been taken").should be_true
		User.all.each{|m| m.destroy}
		@u1.destroy

	end
  end

  describe "Test passwd" do

    before(:each) do
      @u = User.new
      @u.login = "jriby"
    end

    it "Should call the encryption sha1" do

      Digest::SHA1.should_receive(:hexdigest).with("pass").and_return("ok")
      @u.passwd = "pass"
      @u.passwd.should == "\"ok\""
    end

    it "Should encrypt the pass" do

      @u.passwd = "pass"
      @u.passwd.should == "\"9d4e1e23bd5b727046a9e3b4b7db57bd8d6ee684\""
    end

  end
end


describe "Tests of methods" do
  describe "Test of create" do
    before do
        @params = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
    end

    context "User is valid" do
      it "Should create the user" do
        @user = User.create(@params['user'])
        @user.should be_valid
        @user.destroy
      end
     end


    context "User is not valid" do
      it "Should not be valid if the login is empty" do
        @params['user']["login"] = ""
        @user = User.create(@params['user'])
        @user.should_not be_valid
        @user.destroy
      end

      it "Should not be valid if the pass is empty" do
        @params['user']["passwd"] = ""
        @user = User.create(@params['user'])
        @user.should_not be_valid
        @user.destroy
      end

      it "Should not be valid if the pass is nil" do
        @params['user']["passwd"] = nil
        @user = User.create(@params['user'])
        @user.should_not be_valid
        @user.destroy
      end

      it "Should not be valid if the login is nil" do
        @params['user']["login"] = nil
        @user = User.create(@params['user'])
        @user.should_not be_valid
        @user.destroy
      end

    end

  end

  describe "Test of method present?" do
before do
        @params = { 'user' => {"login" => "jgoin", "passwd" => "pass" }}
    end

    it "Should use find_by_login" do

        User.should_receive(:find_by_login).with('jriby')
        User.present?('jriby', 'pass')
    end

    it "Should return true if the user is present" do
        @user = User.create(@params['user'])
        User.present?('jgoin', 'pass').should be_true
        @user.destroy
    end

    context "will return false"

      it "Should not be valid if the user is not present" do
        User.present?('looool', 'pass').should be_false
      end
 
      it "Should not be valid if the user is not given" do
        User.present?(nil, 'pass').should be_false
      end

      it "Should not be valid if the pass is not given" do
        User.present?('looool', nil).should be_false
      end

      it "Should not be valid if the login and the pass is not given" do
        User.present?(nil, nil).should be_false
      end


  end
end

  describe "Test of method delete" do

    it "Should delete the user and all apps of the user" do

      params_user = { 'user' => {"login" => "jriby", "passwd" => "pass" }}
      user = User.create(params_user['user'])     
   
      params_app1 = { 'application' => {"name" => "appli1", "url" => "http://www.julienriby.fr", "user_id" => user.id}}
      application1 = Application.create(params_app1['application'])

     params_app2 = { 'application' => {"name" => "appli2", "url" => "http://www.juliengoin.fr", "user_id" => user.id}}
     application2 = Application.create(params_app2['application'])

     User.delete(user)
     User.find_by_login(user.login).should == nil
     Application.find_by_name(application1.name).should == nil
     Application.find_by_name(application2.name).should == nil

    end

  end
end

