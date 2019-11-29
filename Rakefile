require 'nokogiri'
require 'open-uri'

desc 'get ranking ,read ' #説明
task 'bookmark' do #処理

  doc = setup_doc('https://b.hatena.ne.jp/hotentry/it')
  x = '//a [@class="js-keyboard-openable"]'
  url_ary = []

  doc.xpath(x).each_with_index do |node,i|
    break if i == 7
    puts "#{i+1}. #{node[:title]}\n\n"
    #puts node.to_s.match(/(?<=title=")([^"]+)/)
    url_ary << node[:href]
  end
  
  puts "\n読みたい記事を番号で指定してください。終了する際はq"
  
  while true do
    index = STDIN.gets.chomp
    case index
    when /[1-7]/
      system("open #{url_ary[index.to_i - 1]}")
    when /q/i
      break
    end
  end
  
end

def setup_doc(url)
  charset = 'utf-8'
  html = open(url) { |f| f.read }
  Nokogiri::HTML.parse(html, nil, charset)
end