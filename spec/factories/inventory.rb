FactoryGirl.define do
  factory :inventory, class: Inventory do
    id { generate(:random_id) }
    key { generate(:random_id) }
    name { "Inventory#{id}" }
    owner { create(:user) }

    trait :with_hosts do
      hosts { create_list(:host, 3, inventory_id: id) }
    end

    factory :small_inventory, traits: [:with_hosts]
    factory :big_inventory, traits: [:with_hosts]
  end

end