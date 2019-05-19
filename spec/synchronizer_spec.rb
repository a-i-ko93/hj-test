describe Synchronizer do
  describe '.execute' do
    let(:external_reference) { 1 }
    let(:campaign_attributes) { FactoryBot.attributes_for(:campaign, external_reference: external_reference) }
    let(:campaign) { CampaignRepository.new.create(campaign_attributes) }
    let!(:body) do
      {
        ads: [
          { reference: external_reference, status: campaign.status, description: campaign.ad_description }
        ]
      }
    end

    before do
      stub_request(:get, AdImporter::CAMPAIGN_URL).to_return(body: body.to_json)
    end

    subject { described_class.new.execute }

    context 'without errors' do
      let!(:expected_output) { [AdComparer.new(campaign, body[:ads].first).execute] }

      it { is_expected.to eq(expected_output) }
    end

    context 'with errors' do
      before { allow_any_instance_of(AdComparer).to receive(:execute).and_raise }

      it { is_expected.to eq(described_class::FAILURE_MESSAGE) }
    end
  end
end
