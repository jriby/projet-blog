class SessionsController < ApplicationController
  include SessionsHelper

  def new

    if is_connected?
      redirect_to posts_path
    
    elsif !params['secret']
      redirect_to 'http://sauth:6666/sessions/new/app/app_blog?origin=/sessions/new'

    elsif params['secret']=="jesuisauth"
      session["current_user_blog"] = params['login']
      redirect_to posts_path
    else
      redirect_to :root, :status => 403
    end
  end
end
