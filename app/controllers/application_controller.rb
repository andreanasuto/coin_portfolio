require './config/environment'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'rack-flash'


class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Twitter::Bootstrap::Assets
  set :session_secret, "my_application_secret"
  set :views, 'app/views'

  get '/' do
    if logged_in?
      redirect "/coins"
    else
      redirect "/signup"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_loggedin
      unless logged_in?
        redirect '/login'
      end
    end

  end
end
