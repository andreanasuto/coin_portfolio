class CoinController < ApplicationController

  get '/coins/new' do
    @coins = Scraper.new.get_coin_names
    erb :"coins/new"
  end

  post '/coins' do
    @coin = Coin.create(name: params[:name], quantity: params[:quantity])
    redirect :"/coins/#{@coin.slug}"
  end

  get '/coins/:slug' do
    @coin = Coin.find_by_slug(params[:slug])
    erb :"coins/show"
  end

  get '/coins/:slug/edit' do
    erb :"coins/edit"
  end
end
