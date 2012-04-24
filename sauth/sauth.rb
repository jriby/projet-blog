$: << File.dirname(__FILE__)
require 'sinatra'
require 'lib/user'
require 'lib/application'
require 'lib/utilisation'
require 'active_record'
require 'logger'
require 'bdd/database'

set :port, 6666

use Rack::Session::Cookie, :key => 'rack.session.sauth',
                           :expire_after => 86400, #1 jour
                           :secret => 'hey'

set :logger , Logger.new('log/log_sessions.txt', 'weekly')

helpers do
  def current_user
    session["current_user"]
  end

  def disconnect
    session["current_user"] = nil
  end
end

before '/' do
  @user = current_user
end

before '/applications/new' do
  redirect "/sessions/new" if !current_user
end


before '/sessions/new/app/:appli' do
  redirect 404 if !Application.present?(params[:appli]) || !params[:origin]
end



#########################
# Portail d'inscription
#########################
get '/users/new' do

  erb :"users/new"

end

post'/users' do
  
  @u = User.create(params['user'])
  
  if @u.valid?
    redirect '/sessions/new'
  else
    @error = @u.errors.messages
    erb :"users/new"
  end
end


#########################
# Portail de connection
#########################
get '/sessions/new' do
          
          erb :"sessions/new"

end

post '/sessions' do

  if User.present?(params['login'],params['passwd'])
    settings.logger.info("Connexion depuis le sauth de => "+params["login"])
    session["current_user"] = params['login']
    redirect "/"
  else
    @login = params['login']
    @error_con = "Les infos saisies sont incorrectes"
    settings.logger.info("Tentative de connexion failed pour "+params['login'])
    erb :"/sessions/new"
  end

end

#########################
# Deco
#########################
get '/sessions/disconnect' do
   disconnect
   redirect "/sessions/new"
end

#########################
# Index
#########################
get "/" do
  erb :"/index"
end



#########################
# Profile utilisateur
#########################
get "/users/:login" do

  if session["current_user"] == params[:login]
    user = User.find_by_login(params[:login])
    uid = user.id
    @user = current_user
    
    @apps = Application.where(:user_id => uid)
    @utils = Utilisation.where(:user_id => uid)

    if current_user == "admin"
      @users = User.all
    end
    erb :"users/profil"
  else
    403
  end

end



#########################
# Portail d'inscription d'appli
#########################
get '/applications/new' do

    erb :"/applications/new"

end

post '/applications' do

  @u = User.find_by_login(current_user)
  params['application']['user_id'] = @u.id
  
  @a = Application.create(params['application'])


  if @a.valid?
    @params_util = { 'utilisation' => {"application" => @a, "user" => @u}}
    @utilisation = Utilisation.create(@params_util['utilisation'])
    @user = @u.login
    redirect "/users/#@user"
  else
    @error = @a.errors.messages
    erb :"/applications/new"
  end

end


#########################
# Destruction d'appli
#########################

delete "/application/:name" do

  if session["current_user"]
    app = Application.find_by_name(params["name"])

    if app
      user = User.find_by_login(session["current_user"])

      if app.user_id != user.id
        403

      else
        Application.delete(app)
        @user = current_user
        redirect :"/users/#@user"
      end

    else
      404
    end

  else
    403
  end
end


#########################
# Destruction de user
#########################
delete "/users/:login" do

  @user = current_user
  usr = User.find_by_login(params["login"])

  if @user == "admin"
    if usr
      User.delete(usr)
      redirect :"/users/admin"
    else
       404
     end

   else
    403
  end


end

#########################
# Error
#########################
error 403 do
   erb :forbidden
end
error 404 do
   erb :notfound
end


get '/sessions/new/app/:appli' do
  
    if current_user
      user = User.find_by_login(session["current_user"])
      appl = Application.find_by_name(params[:appli])
    
      if !Utilisation.present?(user, appl)
        settings.logger.info("L'utilisateur "+user.login+" s'est inscrit a l'application "+appl.name)
        params_util = { 'utilisation' => {"application" => appl, "user" => user}}
        Utilisation.create(params_util['utilisation'])
      end

      log = session["current_user"]
      url=appl.url+params[:origin]

      settings.logger.info("L'utilisateur "+user.login+" utilise l'application "+appl.name)

      redirect "#{url}?login=#{log}&secret=jesuisauth"
  
    else
      appl = Application.find_by_name(params[:appli])
      @appli=params[:appli]
      @back_url=appl.url+params[:origin]
      erb :"sessions/appli"
    end

end
post '/sessions/app/:appli' do

  if User.present?(params['login'],params['passwd'])

    user = User.find_by_login(params[:login])
    appl = Application.find_by_name(params[:appli])

    login=params["login"]
    session["current_user"]=login

    if !Utilisation.present?(user, appl)
      settings.logger.info("L'utilisateur "+login+" inscrit a l'application "+params[:appli])
      params_util = { 'utilisation' => {"application" => appl, "user" => user}}
      Utilisation.create(params_util['utilisation'])
    end

    settings.logger.info("L'utilisateur "+login+" utilise l'application "+params[:appli])
    redirect "#{params[:back_url]}?login=#{params[:login]}&secret=jesuisauth"
  else
    @login = params['login']
    @back_url=params[:back_url]
    @error_con = "Les infos saisies sont incorrectes"
    @appli=params[:appli]
    settings.logger.info("Tentative de connexion failed pour "+params['login'])
    erb :"sessions/appli"
  end
end
