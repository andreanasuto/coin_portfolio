class CoinController < ApplicationController

  get '/coins' do
    #if logged_in?
      @coins = Coin.all
      erb :"/coins/coins"
    #else
    #  redirect :"/login"
    #end
  end

  get '/coins/new' do
    @coins = Scraper.new.get_coin_names
    erb :"coins/new"
  end

  post '/coins' do
    if !params[:name].empty? && !params[:quantity].empty?
      @coin = Coin.create(name: params[:name], quantity: params[:quantity])
    end
    redirect :"/coins/#{@coin.slug}"
  end

  get '/coins/:slug' do
    @coin = Coin.find_by_slug(params[:slug])
    erb :"coins/show"
  end

  get '/coins/:slug/edit' do
    @coin = Coin.find_by_slug(params[:slug])
    erb :"coins/edit"
  end

  post '/coins/:slug' do
    @coin = Coin.find_by_slug(params[:slug])
    @coin.update(quantity: params[:quantity])
    redirect :"/coins/#{@coin.slug}"
  end
end
