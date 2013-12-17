module API
  module V2
    module Entities
      class Inventory < V1::Entities::Inventory
        def initialize(inventory)
          super(inventory)

          @_meta = { hostvars: {} }
          inventory.hosts.find_each do |host|
            @_meta[:hostvars][host.alias] = ActiveSupport::JSON.decode(host.variables)
          end
        end
      end
    end

  	class API < Grape::API
      format :json
      version 'v2', using: :path

      before do
        error!('Unauthorized', 401) unless authenticated?
      end

      params do
        requires :token, type: String
      end
      resource  :inventory do
        desc "Inventory"
        get ':id' do
          inventory = Inventory.find_by(key: params[:id])
          error!('Not Found', 404) if inventory.nil?
          
          Entities::Inventory.new(inventory)
        end
      end
  	end
  end
end