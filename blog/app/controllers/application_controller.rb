class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    session["current_user_blog"]
  end


  def self.is_connected?
    !self.current_user.nil?
  end

  def self.must_be_connected
    redirect_to(new_session_path) unless self.is_connected?
  end
  
end
