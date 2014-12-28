require_relative "../../spec_helper"
require_relative "../../../lib/converter/type2json_schema"

require_relative "../../../lib/scraper/type"
require_relative "../../../lib/scraper/property"
require_relative "../../../lib/scraper/expected_type"

describe Type2JsonSchema do
  let(:converter) { Type2JsonSchema.new }
  let(:type) {
    type = SchemaOrg::Scraper::Type.new
    type.name = "Thing"
    type.url = "http://schema.org/Thing"
    type.description = "description"

    property = SchemaOrg::Scraper::Property.new
    property.url = "http://schema.org/additionalType"
    property.name = "additionalType"
    property.description = "description"
    ext = SchemaOrg::Scraper::ExpectedType.new
    ext.name = "Thing"
    ext.url = "http://schema.org/Thing"
    property.types = [ext]

    property2 = SchemaOrg::Scraper::Property.new
    property2.url = "http://schema.org/additionalType"
    property2.name = "additionalType"
    property2.description = "description"
    ext2 = SchemaOrg::Scraper::ExpectedType.new
    ext2.name = "URL"
    ext2.url = "http://schema.org/URL"
    property2.types = [ext2]

    type.properties = [property, property2]
    type
  }
  let(:schema) { converter.to_schema(type) }

  it { expect(schema._schema).to eq "http://json-schema.org/draft-04/schema#" }
  it { expect(schema.id).to eq "http://schema.org/Thing" }
  it { expect(schema.name).to eq "Thing" }
  it { expect(schema.title).to eq "Thing" }
  it { expect(schema.description).to eq "description" }
  it { expect(schema.type).to eq "object" }
  it { expect(schema.required).to eq false }

  it { expect(schema.properties.first.key).to eq "additionalType" }
  it { expect(schema.properties.first.id).to eq "http://schema.org/additionalType" }
  it { expect(schema.properties.first.required).to eq false }
  it { expect(schema.properties.first.title).to eq "additionalType" }
  it { expect(schema.properties.first.description).to eq "description" }
  it { expect(schema.properties.first.type).to eq "object" }
  it { expect(schema.properties.first.properties.first.ref).to eq "Thing.json#/properties" }

  it { expect(schema.properties[1].type).to eq "string" }
  it { expect(schema.properties[1].properties).to eq [] }

end