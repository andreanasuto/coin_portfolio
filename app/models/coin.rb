class Coin < ActiveRecord::Base
  belongs_to :user

  def slug
    name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

  end

  def self.find_by_slug(string)
    self.all.find {|coin| coin.slug == string}
  end

  def to_dollar
    self.quantity * Scraper.new.get_coin_value(self.slug).to_f
  end
end
