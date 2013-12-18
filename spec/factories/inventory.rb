FactoryGirl.define do
  factory :inventory, class: Inventory do
    id { generate(:random_id) }
    key { generate(:random_id) }
    name { "Inventory#{id}" }
    owner { create(:user) }

    trait :with_hosts do
      hosts { create_list(:host_with_vars, 3, inventory_id: id) }
    end

    trait :with_group do
      groups { create_list(:group, 1, inventory_id: id) }
    end

    trait :with_groups do
      groups { create_list(:group, 3, inventory_id: id) }
    end

    factory :inventory_with_hosts, traits: [:with_hosts]
    factory :inventory_with_group, traits: [:with_group]
    factory :inventory_with_groups, traits: [:with_groups]

    factory :inventory_with_groups_hosts, traits: [:with_groups, :with_hosts]
  end

end