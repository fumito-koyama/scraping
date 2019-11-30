require 'nokogiri'
require 'open-uri'

class  RankingScraping

  def initialize(url)
    @doc = RankingScraping.setup_doc url
    @title_ary = []
    @url_ary = []
  end

  def get_element (x)
    @doc.xpath(x).each_with_index do |node,i|
      break if i == 7
      @title_ary << node[:title]
      @url_ary << node[:href]
    end
  end

  def view_title
    @title_ary.each_with_index {|e,i| puts "#{i+1}. #{e}\n\n"}
  end

  def choice_article
    puts "\n読みたい記事を番号で指定してください。終了する際はq"
  
    while true do
      index = STDIN.gets.chomp
      case index
      when /\A[1-7]\z/
        system("open #{@url_ary[index.to_i - 1]}")
      when /\Aq\z/i
        return
      end
    end
  end


  private
  def self.setup_doc(url)
    charset = nil
    begin
    html = open(url) do |f| 
      charset = f.charset
      f.read
    end
    rescue => e
      puts e
      return
    end
    Nokogiri::HTML.parse(html, nil, charset)
  end
end