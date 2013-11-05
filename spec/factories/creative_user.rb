# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :creative_user do
    sequence(:name) { |i| "Artist #{i}" }
    sequence(:email) { |i| "email#{i}@example.com" }
    in_queue true
    title "Greenhorn"
    password "secret"
    password_confirmation "secret"
  end
end
