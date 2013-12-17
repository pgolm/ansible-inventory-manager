FactoryGirl.define do
  factory :user, class: User do
    id { generate(:random_id) }
    uid { generate(:random_id) }
    provider "dummy"
    email { "admin#{id}@example.com" }
    api_key { generate(:random_id) }
  end
end