class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest

    if user.is_admin?
        # admin
        can :manage, :all
    elsif not user.uid.nil?
        # user
        # TODO: only user stuff
        can :manage, Inventory
        can :manage, Host
        can :manage, Group

        can :manage, user
    else
        # guest
        can :create, Identity if AnsibleWebInventory::Application.config.registration
    end
  end
end
