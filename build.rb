require_relative "lib/scraper/type_scraper"
require_relative "lib/converter/type2json_schema"
require "json"

Dir.glob("./tmp/*.html").each do |filepath|
  puts "Started to compile #{filepath}"

  html = File.read(filepath)
  name = filepath.split("/").last.split(".").first # ./tmp/WholesaleStore.html -> WholesaleStore
  url = "http://schema.org/#{name}"
  scraper = SchemaOrg::Scraper::TypeScraper.new(html, url)
  type = scraper.scrape
  schema = Type2JsonSchema.new.to_schema(type)
  json = JSON.pretty_generate schema.to_hash

  File.open("build/#{name}.json", "w") { |f| f.write json }
end