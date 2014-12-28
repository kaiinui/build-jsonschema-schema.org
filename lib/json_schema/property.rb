require_relative "json_schema"

class JsonSchema::Property
  attr_accessor :key, # String
                :id, # String
                :required, # Boolean
                :format, # String @see http://json-schema.org/latest/json-schema-validation.html#anchor104
                :title, # String
                :description, # String
                :type, # String
                :properties, # Array<JsonSchema::Property>
                :ref, # String

  def initialize
    self.properties = []
  end

  def to_hash
    if !self.ref
      _to_hash
    else
      { "$ref" => self.ref }
    end
  end

  def _to_hash
    hash = {}
    hash["id"] = self.id if self.id
    hash["required"] = self.required if self.required != nil
    hash["title"] = self.title if self.title
    hash["description"] = self.description if self.description
    hash["type"] = self.type
    hash["format"] = self.format if self.format
    if self.properties && self.properties.size > 0
      hash["properties"] = _property_hash
    end
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