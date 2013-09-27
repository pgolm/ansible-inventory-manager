module Variabable
  extend ActiveSupport::Concern

  included do
    before_save :jsonify_vars
  end

  def jsonify_vars
    unless variables.nil?
      begin
        self.variables = ActiveSupport::JSON.decode(variables).to_json
      rescue
        yaml = YAML::load(variables)
        unless yaml
          self.variables = "{}"
        else
          self.variables = yaml.to_json 
        end
      end
    end
  end
end