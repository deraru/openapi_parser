class OpenAPIParser::SchemaValidator
  class ArrayValidator < Base

    # @param [Array] value
    # @param [OpenAPIParser::Schemas::Schema] schema
    def coerce_and_validate(value, schema)
      return validator.validate_error(value, schema) unless value.is_a?(Array)

      # array type have an schema in items property
      items_schema = schema.items


      coerced_values = value.map do |v|
        coerced, err = validator.validate_schema(v, items_schema)
        return [nil, err] if err

        coerced
      end

      value.each_index { |idx| value[idx] = coerced_values[idx] } if @coerce_value

      [value, nil]
    end
  end
end