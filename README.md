# Coin Portfolio
An easy way to know how much money is worth your investments.
A no-frills portfolio tracker for cryptocurrencies.
This project has been developed using Ruby, Sinatra and Nokogiri gem to scrape data.


# Why
## Back in 2011
I first heard about Bitcoin in 2011 during a discussion with a bunch of friends studying finance as me. For the following years, I’ve never touched or thought about buying bitcoins until I came across another discussion, similar set up (a bunch of friends sitting at one table) but different location, the US instead of Italy. This time I did my research.

## Problem - I
I was surprised by the lack of information, the ‘greyness’ of the market and the absence of old school financial-statistical tools and analysis as a basic Markowitz portfolio optimization. After all, I was a student in finance once. I’ve started to buy some coins with a tiny amount of money, mostly as trading experiments. I ended up creating another old school tool, an Excel spreadsheet with my different positions and the trades that I had. I’ve bought some coins and sold others across the time but still I had another issue.

## Problem - II
The fluctuation of the cryptocurrencies is well-know. In a day a coin can lose 20% of its value while gaining back its price one day later: it’s a rollercoaster. Having the current value of multiple coins (i.e. a portfolio) can be a nightmare, since you have to daily get by hand the price of each coin, multiply the dollar value of each coin for your quantity and lastly sum all this up.

## User Research
Before jumping into coding, I’ve borrowed my skills and experience as a human-centered researcher to study and extract some hints from real user cases. I’ve reached out to some friends investing in alt-coins asking about their routines with these investments to create a study sample. I was impressed by how many times they check how the market is going per day: an average of 9 times a day! Secondly, some of them have similar spreadsheets as mine. Some they had the total value of the investments (this creates a sub-issue: how can you manage a *portfolio* if you don't know which coin is performing better?), other user interviewed they have a spreadsheet for each coin position and endless trading book sheets with no chance to extract proper valid short information. Lastly, the 'rough guys': investors that they simply compound the gain or loss on the flight with no precision at all.

## User Research Take aways
I am interested (as the majority of investors) firstly in the total value of the portfolio and its gain, secondly in a detailed analysis/price trends for each coin. Even if I am a fan of data, I was looking for something incredibly simple. In other words: a tool that tells me clearly and firstly how much money is worth my investment. Nothing more. Clarity and simplicity before a Pandora’s box of charts open up.

## Solution
### Scraping with Nokogiri
First of all, I need an automated solution to get data, mainly coin prices. [Coinmarketcap.com](https://coinmarketcap.com/) is probably the best source, thanks to his all-encompassing listing of alt-coins and their relative information. Using Nokogiri, a beautiful Ruby gem, I was able to extract the price for each coin. But it wasn’t enough. New coins come out pretty quickly, only 2017 there were 235 new ICO (source: coinschedule). I also needed to constantly get these new **coin names** with its prices.

### Interface
After creating a simple login/signup page, using the findings from the user research, I’ve built the main page where all the fundamental actions take place.
On top the current total value of the portfolio, below the compositions of the portfolio with cryptocurrencies you have been investing in and an immediate call to action to add a coin and its quantity to the portfolio. In this way, you can add or remove coins without going on another page. Surprisingly, this works like AJAX solution without AJAX (plus: I didn't know about AJAX while I was creating this!).
In order to add a coin you can choose from a pre-filled list of coins. These names come from the web scraping on Coinmarketcap. No duplicates or manual entry is possible so I've avoided having problems while matching the coin entry with its price information coming from the scraping.
The information for each coin (like its price, value in bitcoin and so forth) is reduced to two: price and quantity. However, you can still visit a single coin page and perform a similar action while seeing more information.

### Installing

First, clone this repo through your terminal:

```
git clone
```

Secondly, run migrations:

```
rake db:migrate
```

The repo uses 'shotgun' gem to run locally. Just type:

```
shotgun
```
You'll see running on your browser the app.
Enjoy!
