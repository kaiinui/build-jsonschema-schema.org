require_relative "scraper"
require_relative "type"
require_relative "property"
require_relative "expected_type"
require "nokogiri"
require "uri"

# @see spec/lib/scraper/Thing.html
class SchemaOrg::Scraper::TypeScraper
  # @param html [String]
  # @param url [String]
  def initialize(html, url)
    @doc = Nokogiri::HTML(html)
    @url = url
  end

  # @return [SchemaOrg::Scraper::Type]
  def scrape
    type = SchemaOrg::Scraper::Type.new
    type.name = name
    type.description = description
    type.properties = properties
    type.url = @url

    type
  end

  # @return [String]
  def name
    @doc.css(".page-title a").text
  end

  # @return [String]
  def description
    @doc.css("[property~='rdfs:comment']").first.text
  end

  # @return [Array<Property>]
  def properties
    _definition_table.css("tbody tr").map do |p|
      property = SchemaOrg::Scraper::Property.new
      property.url = p["resource"]
      property.name = p.css("[property~='rdfs:label']").text
      property.types = p.css(".prop-ect a").map do |inc|
        type = SchemaOrg::Scraper::ExpectedType.new
        type.name = inc.text
        type.url = URI.join(@url, inc["href"]).to_s
        type
      end
      property.description = p.css("[property~='rdfs:comment']").text

      property
    end
  end

  def _definition_table
    @doc.css(".definition-table").first
  end
end