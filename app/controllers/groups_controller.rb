class GroupsController < ApplicationController
  include InventoryAction
  before_action :find_inventory, only: [:new, :create, :update, :destroy]

  def new
    @group = Group.new
    @group.inventory = @inventory
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:notice] = "Group was created"
      redirect_to @inventory
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:notice] = "Group was updated."

      redirect_to @group.inventory
    else
      render :edit
    end
  end

  def destroy
    begin
      Group.find(params[:id]).destroy
      flash[:notice] = 'Group was deleted.'
    rescue
      flash[:alert] = "Group couldn't be deleted."
    end

    redirect_to @inventory 
  end

  private

  # def find_inventory
  #   @inventory = Inventory.find(params[:inventory_id])
  # end

  def group_params
    if current_user
      params.require(:group).permit(:name,
        :description,
        :variables, 
        :inventory_id,
        :hosts => []) 
    end
  end
end
