require_relative "../../spec_helper"
require_relative "../../../lib/json_schema/json_schema"

describe JsonSchema::JsonSchema do
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
    property.types = []

    type.properties = [property]
    type
  }
  let(:schema) { converter.to_schema(type) }
  let(:json) { schema.to_hash }
  let(:properties) { json["properties"] }

  it { expect(schema.filename).to eq "Thing.json" }

  it { expect(json["$schema"]).to be_true }
  it { expect(json["name"]).to eq "Thing" }
  it { expect(json["id"]).to eq "http://schema.org/Thing" }
  it { expect(json["description"]).to eq "description" }

  it { expect(json["properties"]).to be_kind_of Hash }
  it { pp properties }
  it { expect(properties["additionalType"]["description"]).to eq "description" }
  it { expect(properties["additionalType"]["id"]).to eq "http://schema.org/additionalType" }
  it { expect(properties["additionalType"]["title"]).to eq "additionalType" }
  it { expect(properties["additionalType"]["required"]).to eq false }
end