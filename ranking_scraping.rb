require 'nokogiri'
require 'open-uri'

class  RankingScraping

  def setup_doc(url)
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

  def get_element (x,title_ary,url_ary)
    x.each_with_index do |node,i|
      break if i == 7
      title_ary << node[:title]
      url_ary << node[:href]
    end
  end
end