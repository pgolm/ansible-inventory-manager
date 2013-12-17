FactoryGirl.define do
  factory :group, class: Group do
    id { generate(:random_id) }
    name { "group#{id}" }
    association :inventory, factory: :inventory

    trait :with_hosts do
      hosts { create_list(:host, 2, inventory_id: inventory_id) }
    end

    factory :group_with_hosts, traits: [:with_hosts]
  end
end