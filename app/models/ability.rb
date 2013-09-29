class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest

    # alias
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.is_admin? # admin
        can :manage, :all
    elsif not user.uid.nil? # user
        can :crud, Inventory, user_id: user.id
        can :crud, Host
        can :crud, Group
        can :crud, user
    else # guest
        can :create, Identity if AnsibleWebInventory::Application.config.registration
    end
  end
end
