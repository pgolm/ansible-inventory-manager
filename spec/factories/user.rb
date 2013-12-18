FactoryGirl.define do
  factory :user, class: User do
    id { generate(:random_id) }
    uid { generate(:random_id) }
    provider "identity"
    email { "admin#{id}@example.com" }
    api_key { generate(:random_id) }
  end

  factory :identity, class: Identity do
    id { generate(:random_id) }
    email { "user#{id}@example.com" }
    password { "password#{id}" }
    password_confirmation { "#{password}" }

    trait :known do
      before :create do |user| 
        create(:user, uid: user.id, email: user.email) 
      end
    end

    factory :known_identity, traits: [:known]
  end
end