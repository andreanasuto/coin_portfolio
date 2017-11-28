class CoinController < ApplicationController

  get '/coins/new' do
    @coins = Coin.all
    erb :"coins/new"
  end

  get '/coins/:id' do
    erb :"coins/show"
  end

  get '/coins/:id/edit' do
    erb :"coins/edit"
  end
end
