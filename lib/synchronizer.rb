class Synchronizer
  FAILURE_MESSAGE = 'Failed to synchronize campaigns'.freeze

  def initialize
    @external_ads = AdImporter.execute
    @campaigns = CampaignRepository.new.all
  end

  def execute
    begin
      @campaigns.map do |campaign|
        responding_external_ad = @external_ads.detect do |external_ad|
          campaign.external_reference.to_s == external_ad[:reference].to_s
        end
        AdComparer.new(campaign, responding_external_ad).execute
      end
    rescue => e
      FAILURE_MESSAGE
    end
  end
end
