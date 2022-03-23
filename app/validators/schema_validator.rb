require "json-schema"
class SchemaValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # Looks for a JSON schema as a class constant
    c = "#{attribute.upcase}_SCHEMA"
    begin
      schema = record.class.const_get(c)
    rescue NameError => e
      raise(
        $!,
        "Expected #{record.class.name}::#{c} to declare a JSON Schema for #{attribute}",
        $!.backtrace
      )
    end
    unless JSON::Validator.validate(schema, value, { json: options[:json], :list => options[:list] })
      record.errors.add(attribute, 'Does not comply to JSON Schema')
    end
  end
end