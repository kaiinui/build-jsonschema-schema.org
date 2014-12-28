require_relative "../schema_org"
require "open-uri"
require_relative "../scraper/type_list_scraper"

TYPE_LIST_URL = "http://schema.org/docs/full.html".freeze

class SchemaOrg::Crawler
  # @param tmp_path [String] Temporary file path for saving HTML files.
  def initialize(tmp_path)
    @tmp = tmp_path
  end

  def run
    puts "Started to fetch #{TYPE_LIST_URL}"
    fetch_type_list.each do |url|
      puts "Started to fetch #{url}"
      fetch_type url
    end
  end

  def fetch_type(url)
    html = open(url).read
    filename = url.split("/").last
    File.open("#{@tmp}/#{filename}.html", "w") {|f| f.write html }
  end

  # @return [Array<String>] A list of URLs
  def fetch_type_list
    html = open(TYPE_LIST_URL).read
    scraper = SchemaOrg::Scraper::TypeListScraper.new(html)
    scraper.scrape
  end
end