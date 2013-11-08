# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :virtual_request do
    sequence(:company)  { |n| "Company #{n}" }
    due_date Time.now
    contact_name "Jim Distributor"
    contact_email  "jim@distributor.com"
    contact_phone "1-900-mix-alot"
    quantity "1,000"
    budget "$5.00"
    artist_id 2
    creative_user_id 6
    art_url "www.pappajohns.com"
    association :creative_user
  end
end
