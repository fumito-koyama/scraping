require 'nokogiri'
require 'open-uri'
require './ranking_scraping.rb'
require './lib/scraper'

desc 'get ranking ,view ' #説明
task 'bookmark' do #処理

  url = 'https://b.hatena.ne.jp/hotentry/it'
  x = '//a [@class="js-keyboard-openable"]'

  rs = RankingScraping.new(url)

  rs.get_element(x)
  rs.view_title

  rs.choice_article
end

task :bookmark2 do
  begin
    bookmarks = Scraper::parse!
  rescue => e
    puts "エラーが発生しました"
    puts e.message
    puts e.backtrace
    exit 1
  end

  puts "読みたい記事を番号で指定してください。quite: q"
  puts bookmarks.ranking.join("\n")

  while true do
    rank = STDIN.gets.chomp
    case rank
    when /\A[1-7]\z/
      selected = bookmarks.detect { |bookmark| bookmark.rank == rank.to_i }
      system("open #{selected.url}")
      exit 0
    when /\Aq\z/i
      exit 0
    end
  end
end
