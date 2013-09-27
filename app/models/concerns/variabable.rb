module Variabable
  extend ActiveSupport::Concern

  included do
    before_save :jsonify_vars
  end

  def jsonify_vars
    unless variables.nil? or variables.empty?
      begin
        self.variables = ActiveSupport::JSON.decode(variables).to_json
      rescue
        self.variables = YAML::load(variables).to_json
      end
    end
  end
end