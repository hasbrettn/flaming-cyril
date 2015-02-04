FactoryGirl.define do
  factory :notification do
    title Faker::Lorem.word
    message Faker::Lorem.sentence
    image_url Faker::Internet.url
    email_address Faker::Internet.email
  end
end