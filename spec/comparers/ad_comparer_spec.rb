describe AdComparer do
  #workaround for FactoryBot/Hanami model gem
  let(:campaign_attributes) { FactoryBot.attributes_for(:campaign) }
  let!(:campaign) { CampaignRepository.new.create(campaign_attributes) }

  subject { described_class.new(campaign, external_ad).execute }

  describe '#execute' do
    context 'external ad without errors' do
      let(:external_ad) { FactoryBot.attributes_for(:ad_policy) }
      let(:expected_output) do
        {
          remote_reference: campaign.external_reference,
          discrepancies: described_class::COMPARED_ATTRIBUTES.map do |attr|
            {
              attr => {
                local: campaign.public_send(attr),
                remote: external_ad.to_h[attr]
              }
            }
          end
        }
      end

      it { is_expected.to eq(expected_output) }
    end

    context 'external ad with errors' do
      let(:missing_error) { 'is missing' }
      let(:external_ad) { FactoryBot.attributes_for(:ad_policy).except(:status, :ad_description) }
      let(:expected_output) do
        {
          remote_reference: campaign.external_reference,
          discrepancies: described_class::COMPARED_ATTRIBUTES.map do |attr|
            {
              attr => {
                local: campaign.public_send(attr),
                remote: external_ad.to_h[attr],
                remote_note: missing_error
              }
            }
          end
        }
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end
