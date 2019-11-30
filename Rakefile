require 'nokogiri'
require 'open-uri'
require './ranking_scraping.rb'

desc 'get ranking ,view ' #説明
task 'bookmark' do #処理

  url = 'https://b.hatena.ne.jp/hotentry/it'
  x = '//a [@class="js-keyboard-openable"]'
  
  rs = RankingScraping.new(url)
  
  rs.get_element(x)
  rs.view_title

  rs.choice_article
end