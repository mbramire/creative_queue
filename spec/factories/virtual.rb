# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :virtual do
    recipients "email@email.com, email2@email.com"
    document File.open(File.join(Rails.root, 'spec/fake_data/sample_image.jpg'))
    artist_comments "prepare your pants"
  end
end
