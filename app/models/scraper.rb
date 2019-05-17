class Scraper
  def get_page
      doc = Nokogiri::HTML(open("https://coinmarketcap.com/"))
  end

  def get_coin_names
    names = get_page.css(".currency-name-container").collect {|element| element.text }
    names.map! { |coin| coin == 'Basic Attenti...' ? 'Basic Attention Token' : coin  }
    names.map! { |coin| coin == 'Raiden Networ...' ? 'Raiden Network Token' : coin  }
    names.map! { |coin| coin == 'Santiment Net...' ? 'Santiment' : coin  }
  end

  def get_coin_values
    get_page.css(".price").collect {|element| element.attribute('data-usd').value }
  end

  def get_coin_value(slug)
    get_page.css("#id-#{slug} .price").attribute('data-usd').value
  end
end
