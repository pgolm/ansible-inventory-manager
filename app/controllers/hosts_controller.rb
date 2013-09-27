class HostsController < ApplicationController
  # cancan workaround
  before_filter only: :create do
    @host = Host.new(host_params)
  end

  load_and_authorize_resource
  
  include InventoryAction
  before_action :find_inventory

  def new
    @host = Host.new
    @host.inventory = Inventory.find(params[:inventory_id]) 
  end

  def create
    # @host = Host.new(host_params)
    if @host.save
      flash[:notice] = "Host was created."
      redirect_to inventory_path(params[:inventory_id]) 
    else
      render :new
    end
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])

    if @host.update(host_params)
      flash[:notice] = "Host was updated."

      redirect_to @host.inventory
    else
      @inventory = Inventory.find(params[:inventory_id])
      render :edit
    end
  end

  def show
    @host = Host.find_by(alias: params[:id])

    respond_to do |format|
      format.json { render json: @host.variables }
    end
  end

  def destroy
    begin
      Host.find(params[:id]).destroy
      flash[:notice] = 'Host was deleted.'
    rescue
      flash[:alert] = "Host couldn't be deleted."
    end

    redirect_to inventory_path(params[:inventory_id])
  end

  private

  def host_params
    params.require(:host).permit(:alias, 
      :host, 
      :description,
      :variables,
      :inventory_id,
      :groups => []
      )
  end
end
