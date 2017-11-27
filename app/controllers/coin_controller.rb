class CoinController < ApplicationController

  get '/coins/new' do
    @coins = ["Tizio", "Pippo", "Gianicolo"]
  end

  get '/coins/:id' do
    erb :"coins/show"
  end

  get '/coins/:id/edit' do
    erb :"coins/edit"
  end
end
