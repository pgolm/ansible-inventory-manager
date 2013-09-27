class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      ActiveSupport::JSON.decode(value).to_json unless value.empty?
    rescue ActiveSupport::JSON.parse_error => e
      record.errors[attribute] << e.message
    end
  end
end