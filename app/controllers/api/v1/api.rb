module API
  module V1
    module Entities
      class Inventory
        def initialize(inventory)
          @all = inventory.hosts.map(&:alias)

          inventory.groups.find_each do |group|
            self.instance_variable_set("@#{group.name}".to_sym, {
              hosts: group.hosts.map(&:alias),
              vars: ActiveSupport::JSON.decode(group.variables)
              })
          end
        end
      end
    end

  	class API < Grape::API
      format :json
      version 'v1', using: :path

      before do
        error!('Unauthorized', 401) unless authenticated?
      end

      params do
        requires :token, type: String
      end
      resource  :inventory do
        
        desc "Inventory"
        params do
          requires :id, type: String
        end
        get ':id' do
          inventory = Inventory.find_by(key: params[:id])
          error!('Not Found', 404) if inventory.nil?
          Entities::Inventory.new(inventory)
        end

        desc "Hostvariables"
        params do
          requires :id, type: String
          requires :host, type: String
        end
        get ':id/:host' do
          inventory = Inventory.find_by(key: params[:id])
          error!('Not Found', 404) if inventory.nil?

          host = inventory.hosts.find_by(alias: params[:host])
          error!('Not Found', 404) if inventory.nil?

          ActiveSupport::JSON.decode(host.variables)
        end
      end
  	end
  end
end