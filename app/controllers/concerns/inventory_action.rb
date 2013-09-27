module InventoryAction
  extend ActiveSupport::Concern

  protected
  
  def find_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end
end