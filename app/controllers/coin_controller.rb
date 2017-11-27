class CoinController < ApplicationController

  get '/coins/new' do
    @coin = Scraper.new.get_coin_values.find(params[:coin])
  end

  get '/coins/:id' do
    erb :"coins/show"
  end

  get '/coins/:id/edit' do
    erb :"coins/edit"
  end
end
