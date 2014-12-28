require_relative "../../spec_helper"
require_relative "../../../lib/json_schema/property"

describe JsonSchema::Property do
  context "Only $ref property" do
    let(:property) {
      p = JsonSchema::Property.new
      p.ref = "Thing.json#/properties"
      p.key = "someThing"
      p
    }
    let(:json) { property.to_hash }

    it { expect(json["$ref"]).to eq "Thing.json#/properties" }
  end

  context "Full property" do
    let(:property) {
      p = JsonSchema::Property.new
      p.key = "someURL"
      p.type = "string"
      p.description = "some"
      p.required = false
      p.id = "someURL"
      p
    }
    let(:json) { property.to_hash }

    it { expect(json["type"]).to eq "string" }
    it { expect(json["description"]).to eq "some" }
    it { expect(json["title"]).to be_nil }
    it { expect(json["required"]).to eq false }
    it { expect(json["id"]).to eq "someURL" }
  end
end