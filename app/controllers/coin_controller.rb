class CoinController < ApplicationController

  get '/coins/new' do
    @coins = Scraper.new.get_coin_names
    erb :"coins/new"
  end

  get '/coins/:id' do
    erb :"coins/show"
  end

  get '/coins/:id/edit' do
    erb :"coins/edit"
  end
end
