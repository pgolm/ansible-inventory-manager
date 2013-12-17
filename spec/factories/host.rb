FactoryGirl.define do
  factory :host, class: Host do
    id { generate(:random_id) }
    self.alias { "host#{id}" }
    variables "{}"

    trait :with_variables do
      variables "{ 'ansible_ssh_host': '127.0.0.1'}"
    end
  end
end