class PopulateCampaigns
  def self.execute
    repo = CampaignRepository.new

    1.upto(rand(4..6)) do |i|
      repo.create(
        job_id: "job_#{i}", status: AdPolicy::STATUSES.sample,
        external_reference: i, ad_description: "ad_description_#{i}"
      )
    end
  end
end
