require_relative "scraper"

require "nokogiri"
require "uri"

class SchemaOrg::Scraper::TypeListScraper
  # @param html [String]
  def initialize(html)
    @doc = Nokogiri::HTML(html)
    @domain = "http://schema.org/"
  end

  # @return [Array<String>] A list of URLs
  def scrape
    @doc.css("#Thing a").map {|a| URI.join(@domain, a["href"]).to_s }
  end
end