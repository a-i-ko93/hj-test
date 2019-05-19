FactoryBot.define do
  factory :campaign do
    job_id { Faker::Number.number.to_s }
    status { AdPolicy::STATUSES.sample }
    external_reference { Faker::Number.number.to_s }
    ad_description { Faker::Movies::HarryPotter.character }
  end
end
