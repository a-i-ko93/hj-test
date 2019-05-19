describe AdImporter do
  describe '.execute' do
    subject { described_class.execute }

    context 'response successful' do
      before do
        stub_request(:get, described_class::CAMPAIGN_URL).to_return(body: body.to_json)
      end

      context 'response contains :ads key' do
        let(:body) { { ads: [1, 2, 3] } }
        let(:expected_result) { body[:ads] }

        it { is_expected.to eq(expected_result) }
      end

      context 'response does not contain :ads key' do
        let(:body) { { ods: [1, 2, 3] } }

        it { is_expected.to eq([]) }
      end
    end

    context 'response unsuccessful' do
      before { stub_request(:get, described_class::CAMPAIGN_URL).to_timeout }

      it { is_expected.to eq([]) }
    end
  end
end
