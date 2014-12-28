module JsonSchema
end

class JsonSchema::JsonSchema
  attr_accessor :_schema, # String
                :id, # String
                :required, # Array<String>
                :title, # String
                :name, # String
                :description, # String
                :type, # String
                :properties # Array<JsonSchema::Property>

  def initialize
    self._schema = "http://json-schema.org/draft-04/schema#"
  end

  def filename
    "#{self.name}.json"
  end

  def to_hash
    hash = {
        "$schema" => self._schema,
    }
    hash["id"] = self.id if self.id
    hash["required"] = self.required if self.required != nil
    hash["title"] = self.title if self.title
    hash["name"] = self.name if self.name
    hash["description"] = self.description if self.description
    hash["type"] = self.type
    hash["properties"] = _property_hash
    hash
  end

  def _property_hash
    hash = {}
    self.properties.each do |property|
      hash[property.key] = property.to_hash
    end
    hash
  end
end