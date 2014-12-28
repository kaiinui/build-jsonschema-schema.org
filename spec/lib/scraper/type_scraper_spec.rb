require_relative "../../spec_helper"
require_relative "../../../lib/scraper/type_scraper"

describe SchemaOrg::Scraper::TypeScraper do
  context("Thing.html") do
    let(:type) { html = File.read(File.expand_path("../Thing.html", __FILE__)); SchemaOrg::Scraper::TypeScraper.new(html, "http://schema.org/Thing").scrape }

    it { expect(type.name).to eq "Thing" }
    it { expect(type.description).to eq "The most generic type of item." }
    it { expect(type.url).to eq "http://schema.org/Thing" }

    it { expect(type.properties.size).to eq 8 }
    it { expect(type.properties.first.url).to eq "http://schema.org/additionalType" }
    it { expect(type.properties.first.name).to eq "additionalType" }
    it { expect(type.properties.first.description).to eq "An additional type for the item, typically used for adding more specific types from external vocabularies in microdata syntax. This is a relationship between something and a class that the thing is in. In RDFa syntax, it is better to use the native RDFa syntax - the 'typeof' attribute - for multiple types. Schema.org tools may have only weaker understanding of extra types, in particular those defined externally." }

    it { expect(type.properties[3].types.size).to eq 2 }
    it { expect(type.properties[3].types.first.name).to eq "URL" }
    it { expect(type.properties[3].types.first.url).to eq "http://schema.org/URL" }
  end

  context("AboutPage.html (Child entity)") do
    let(:type) { html = File.read(File.expand_path("../AboutPage.html", __FILE__)); SchemaOrg::Scraper::TypeScraper.new(html, "http://schema.org/AboutPage").scrape }

    it { expect(type.name).to eq "AboutPage" }
  end
end