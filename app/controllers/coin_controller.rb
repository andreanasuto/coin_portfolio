class CoinController < ApplicationController

  get '/coins/new' do
    @coins = Scraper.new.get_coin_names
    erb :"coins/new"
  end

  post '/coins' do
    @coin = Coin.create(name: params[:name], quantity: params[:quantity])
    redirect :"/coins/#{@coin.id}"
  end

  get '/coins/:id' do
    @coin = Coin.find(params[:id])
    erb :"coins/show"
  end

  get '/coins/:id/edit' do
    erb :"coins/edit"
  end
end
