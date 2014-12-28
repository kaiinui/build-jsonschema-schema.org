require_relative "../json_schema/json_schema"
require_relative "../../lib/json_schema/property"

class Type2JsonSchema
  # @param type [SchemaOrg::Scraper::Type]
  # @return JsonSchema::JsonSchema
  def to_schema(type)
    schema = JsonSchema::JsonSchema.new
    schema.id = type.url
    schema.required = false
    schema.title = type.name
    schema.name = type.name
    schema.description = type.description
    schema.type = "object"
    schema.properties = type.properties.map { |p| _property_from_type_property p }
    schema
  end

  # @param p [SchemaOrg::Scraper::Property]
  # @return [JsonSchema::Property]
  def _property_from_type_property(p)
    property = JsonSchema::Property.new
    property.id = p.url
    property.required = false
    property.title = p.name
    property.description = p.description
    property.key = p.name
    if p.types.first
      name = p.types.first.name
      if _is_primitive(name)
        property.type = _primitive_type_map[name]
        property.properties = []
      else
        property.type = "object"
        ref = JsonSchema::Property.new
        ref.key = p.name
        ref.ref = "#{name}.json#/properties"
        property.properties = [ref]
      end
    end
    property
  end

  # @see http://schema.org/DataType
  # @see http://spacetelescope.github.io/understanding-json-schema/reference/type.html
  def _primitive_type_map
    {
        "Text" => "string", # http://schema.org/Text has one child type.
          "URL" => "string",
        "Number" => "number", # http://schema.org/Number has two child types.
          "Float" => "number",
          "Integer" => "number",
        "DateTime" => "string",
        "Time" => "string",
        "Boolean" => "boolean", # http://schema.org/Boolean has two child types.
          "False" => "boolean",
          "True" => "boolean"
    }
  end

  # Whether the type is a primitive type.
  # In example, a "Text" is a primitive. But a "Thing" is NOT a primitive.
  # @param type_name [String]
  # @return [Boolean]
  def _is_primitive(type_name)
    !!_primitive_type_map[type_name]
  end
end