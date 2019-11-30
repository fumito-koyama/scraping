# frozen_string_literal: true

class Scraper
  URL = 'https://b.hatena.ne.jp/hotentry/it'
  TARGET = '//a [@class="js-keyboard-openable"]'

  class << self
    # データの抽出
    def parse!
      bookmarks = []
      doc!.xpath(TARGET).each_with_index do |node,i|
        break if i == 7

        bookmarks << Bookmark.new(rank: i + 1, title: node[:title], url: node[:href])
      end
      @bookmarks = Bookmarks.new(bookmarks)
    end

    private

    # HTML データ取得
    def doc!
      file = open(URL) { |f| f.read }
      Nokogiri::HTML.parse(file, nil, 'utf-8')
    end
  end

  class Bookmark
    attr_accessor :rank, :title, :url

    def initialize(rank:, title:, url:)
      @rank  = rank
      @title = title
      @url   = url
    end
  end

  class Bookmarks
    include Enumerable

    def initialize(bookmarks = [])
      @bookmarks = bookmarks
    end

    def each
      for bookmark in @bookmarks
        yield bookmark
      end
    end

    def ranking
      @bookmarks.map do |bookmark|
        "#{bookmark.rank} #{bookmark.title} #{bookmark.url}"
      end
    end
  end
end
