class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      ActiveSupport::JSON.decode(value).to_json unless value.empty?
    rescue
      begin
        YAML::load(value).to_json unless value.empty?
      rescue
        record.errors[attribute] << 'cannot parse as json or yaml'
      end
    end
  end
end