class AnsibleApiController < ApplicationController
  before_filter :restrict_access
  
  def inventory
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.json { render json: @inventory.as_ansible }
    end
  end

  def host
    @host = Inventory.find(params[:id]).hosts.find_by(alias: params[:host])

    respond_to do |format|
      format.json { render json: @host.variables }
    end
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(api_key: token)
    end
  end
end
