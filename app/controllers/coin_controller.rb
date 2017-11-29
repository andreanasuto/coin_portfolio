class CoinController < ApplicationController

  get '/coins' do
    if logged_in?
      @coins = Coin.where(user_id: current_user.id)
      @sum = 0
      @coins.each { |coin|
        @sum += coin.to_dollar.round(2)
      }
      erb :"/coins/coins"
    else
     redirect :"/login"
    end
  end

  get '/coins/new' do
    if logged_in?
      @coins = Scraper.new.get_coin_names
      erb :"coins/new"
    else
      redirect :"/login"
    end
  end

  post '/coins' do
    if !params[:name].empty? && !params[:quantity].empty?
      @coin = Coin.find_or_create_by(name: params[:name])
      @coin.quantity = 0
      @coin.quantity += params[:quantity].to_f
      current_user.coins << @coin
    end
    redirect :"/coins"
  end

  get '/coins/:slug' do
    if logged_in?
      @coin = Coin.find_by_slug(params[:slug])
      erb :"coins/show"
    else
      redirect :"/login"
    end
  end

  get '/coins/:slug/edit' do
    if logged_in?
      @coin = Coin.find_by_slug(params[:slug])
      erb :"coins/edit"
    else
      redirect :"/login"
    end
  end

  post '/coins/:slug' do
    @coin = Coin.find_by_slug(params[:slug])
    if params[:quantity].to_f >= 0
      @coin.update(quantity: params[:quantity])
      redirect :"/coins/#{@coin.slug}"
    else
      "Sorry bro, you can't store a negative value of a coin!"
    end
  end

  delete '/coins/:slug/delete' do
    if logged_in?
      @coin = Coin.find_by_slug(params[:slug])
      if current_user.coins.include?(@coin)
        @coin.delete
      end
      redirect :"/coins"
    else
      redirect :"/login"
    end
  end
end
