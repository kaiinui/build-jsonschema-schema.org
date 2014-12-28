require_relative "scraper"

class SchemaOrg::Scraper::Property
  attr_accessor :url, # String
                :name, # String
                :types, # Array<ExpectedType>
                :description # String

  def initialize
    self.types = []
  end
end