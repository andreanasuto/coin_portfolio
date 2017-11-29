require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def get_page
      doc = Nokogiri::HTML(open("https://coinmarketcap.com/"))
  end

  def get_coin_names
    get_page.css(".currency-name-container").collect {|element| element.text }
  end

  def get_coin_values
    get_page.css(".price").collect {|element| element.attribute('data-usd').value }
  end

  def get_coin_value(slug)
    get_page.css("#id-#{slug} .price").attribute('data-usd').value
  end
end
#Scraper.new.get_page
#binding.pry
