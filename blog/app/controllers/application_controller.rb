class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :is_connected?, :current_user

  def current_user
    User.find(session)
  end

  def is_connected?
    !current_user.nil?
  end

  def must_be_connected
    redirect_to(new_session_path) unless is_connected?
  end
  
  def post_exist
    redirect_to(new_session_path) unless Post.exist?(params[:post_id])
  end

end
