FactoryBot.define do
  factory :ad_policy do
    status { AdPolicy::STATUSES.sample }
    sequence(:reference) { |i| "external_reference_#{i}" }
    ad_description { Faker::Movies::HarryPotter.character }
  end
end
