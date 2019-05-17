class CoinController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/coins' do

  redirect_if_not_loggedin
    @coins = current_user.coins
    @sum = 0
    @coins.each do |coin|
      @sum += coin.to_dollar.round(2)
    end
    erb :"/coins/coins"
  end

  get '/coins/new' do
    redirect_if_not_loggedin
      @coins = Scraper.new.get_coin_names
      erb :"coins/new"
      redirect :"/login"
  end

  post '/coins' do
    if !params[:name].empty? && !params[:quantity].empty?
      @coin = current_user.coins.find_or_create_by(name: params[:name])
      if @coin.quantity
        @coin.quantity += params[:quantity].to_f
      else
        @coin.quantity = 0
        @coin.quantity += params[:quantity].to_f
      end
      current_user.coins << @coin
    end
    redirect :"/coins"
  end

  get '/coins/:slug' do
    @coin = current_user.coins.find_by_slug(params[:slug])
    if logged_in? && @coin
        erb :"coins/show"
    else
        redirect :"/coins"
    end
  end

  get '/coins/:slug/edit' do
    @coin = current_user.coins.find_by_slug(params[:slug])
    if logged_in? && @coin
      erb :"coins/edit"
    else
      redirect :"/coins"
    end
  end

  put '/coins/subtract' do
    @coin = current_user.coins.find_by(name: params[:name])
    if @coin && !params[:name].empty? && !params[:quantity].empty? && params[:quantity].is_a?(Integer)
      if @coin.quantity >= params[:quantity].to_f
        @coin.quantity -= params[:quantity].to_f
        @coin.save
        redirect :"/coins"
      else
        flash[:error] = "I'm sorry, I cannot remove coins that you don't own"
        redirect :"/coins"
      end
    else
      redirect '/coins'
    end
  end

  put '/coins/:slug' do
    @coin = current_user.coins.find_by_slug(params[:slug])
    if params[:quantity].to_f >= 0
      @coin.update(quantity: params[:quantity])
      redirect :"/coins/#{@coin.slug}"
    else
      flash[:error] = "Sorry, you can't store a negative value of a coin!"
      redirect :"/coins/#{@coin.slug}"
    end
  end

  delete '/coins/:slug/delete' do
    @coin = current_user.coins.find_by_slug(params[:slug])
    if logged_in? && @coin
        @coin.delete
    else
      redirect :"/coins"
    end
  end
end
