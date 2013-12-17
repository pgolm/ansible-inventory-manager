FactoryGirl.define do
  factory :host, class: Host do
    id { generate(:random_id) }
    self.alias { "host#{id}" }
    
    trait :with_variables do
      variables { "{ 'id': #{id} }" }
    end

    factory :host_with_vars, traits: [:with_variables]
  end
end