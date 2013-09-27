class InventoriesController < ApplicationController
  # cancan workaround
  before_filter only: :create do
    @inventory = Inventory.new(inventory_params)
  end

  load_and_authorize_resource

  def new
    @inventory = Inventory.new
  end

  def create
    # @inventory = Inventory.new(inventory_params)
    if @inventory.save
      flash[:notice] = "Inventory was created."
      redirect_to @inventory
    else
      render :new
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update(inventory_params)
      flash[:notice] = "Inventory was updated."

      redirect_to @inventory
    else
      render :edit
    end
  end

  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory.as_ansible }
    end
  end

  def index
    @inventories = Inventory.all
  end

  def destroy
    begin
      Inventory.find(params[:id]).destroy
      flash[:notice] = "Inventory was deleted."
    rescue
      flash[:alert] = "Inventory couldn't be deleted."
    end

    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
