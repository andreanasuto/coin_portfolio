class UserController < ApplicationController

  get '/signup' do
    if @user = User.find_by_id(session[:user_id])
      redirect :'/coins'
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    if !params[:name].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.where(:email => params[:email]).first_or_create do |user|
        session[:user_id] = @user.id
        user.name = params[:name]
        user.email = params[:email]
        user.password = params[:password]
      end
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
    if @user = User.find_by(email: params[:email])
      @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :'/coins'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect :"/login"
    else
      redirect :"/"
    end
  end

end
