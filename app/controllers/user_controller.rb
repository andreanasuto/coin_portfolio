class UserController < ApplicationController

  get '/signup' do
    if @user = User.find_by_id(session[:user_id])
      redirect :'/coins'
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    @user = User.new(:name => params[:name], :email => params[:email] ,:password => params[:password])
    if !params[:name].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
      redirect :"/coins"
    else
      redirect :"/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect :"/coins"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(name: params[:name])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect :'/coins'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect :"/login"
    else
      redirect :"/"
    end
  end

  #get '/users/:slug' do
#    @user = User.find_by_slug(params[:slug])
#    erb :"/users/show"
#  end

end
