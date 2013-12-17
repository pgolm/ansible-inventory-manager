FactoryGirl.define do
  factory :inventory, class: Inventory do
    id { generate(:random_id) }
    key { generate(:random_id) }
    name { "Inventory#{id}" }
    owner { create(:user) }

    trait :with_host do
      hosts { create_list(:host, 1, inventory_id: id) }
    end

    trait :with_hosts do
      hosts { create_list(:host, 12, inventory_id: id) }
    end

    factory :small_inventory, traits: [:with_host]
    factory :big_inventory, traits: [:with_hosts]
  end

end