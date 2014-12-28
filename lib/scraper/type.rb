require_relative "scraper"

class SchemaOrg::Scraper::Type
  attr_accessor :name, # String
                :description, # String
                :properties, # List<Property>
                :url # String

  def initialize
    @properties = []
  end
end