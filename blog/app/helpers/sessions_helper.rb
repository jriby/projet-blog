module SessionsHelper

  def current_user
    session["current_user_blog"]
  end

  def is_connected?
    !current_user.nil?
  end

  def must_be_connected
    redirect_to(new_session_path) unless is_connected?
  end
  
end
