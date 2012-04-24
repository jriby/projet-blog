class SessionsController < ApplicationController

    def current_user
      session["current_user_blog"]
    end

  def new
    if !current_user && !params['secret']
      redirect_to 'http://sauth:6666/sessions/new/app/app_blog?origin=/sessions/new'

    elsif current_user
      redirect_to posts_path

    elsif params['secret']=="jesuisauth" && params['login']
      session["current_user_blog"] = params['login']
      redirect_to posts_path
    else
      redirect_to :root, :status => 403
   end
  end
end
