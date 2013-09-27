class AnsibleApiController < ApplicationController
  #todo: use hash & check apikey
  
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
end
