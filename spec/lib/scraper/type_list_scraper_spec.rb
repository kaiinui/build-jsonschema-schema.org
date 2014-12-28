require_relative "../../spec_helper"
require_relative "../../../lib/scraper/type_list_scraper"

describe SchemaOrg::Scraper::TypeListScraper do
  let(:scraper) { html = File.read("TypeList.html"); SchemaOrg::Scraper::TypeListScraper.new(html) }
  let(:urls) { scraper.scrape }

  it { expect(urls.size > 100).to be true }
  it { expect(urls).to include "http://schema.org/Sculpture" }
end