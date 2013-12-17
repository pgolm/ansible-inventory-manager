FactoryGirl.define do
  factory :host, class: Host do
    id { generate(:random_id) }
    self.alias { "host#{id}" }
  end
end