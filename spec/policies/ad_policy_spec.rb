describe AdPolicy do
  describe 'validations' do
    let(:policy) { described_class.new(attrs).validate }

    %i[reference ad_description status].each do |attribute|
      context "#{attribute} presence validation" do
        context 'when present' do
          let(:attrs) { FactoryBot.attributes_for(:ad_policy) }

          it 'is valid' do
            expect(policy.success?).to be_truthy
          end
        end

        context 'when empty do' do
          let(:attrs) { FactoryBot.attributes_for(:ad_policy).except(attribute) }

          it 'is invalid' do
            expect(policy.success?).to be_falsey
          end

          it 'has errors' do
            expect(policy.errors[attribute].any?).to be_truthy
          end
        end
      end
    end

    context 'status inclusion validation' do
      context 'when status correct' do
        let(:attrs) { FactoryBot.attributes_for(:ad_policy) }

        it 'is valid' do
          expect(policy.success?).to be_truthy
        end
      end

      context 'when status incorrect' do
        let(:attrs) { FactoryBot.attributes_for(:ad_policy).merge(status: 'LOL') }

        it 'is invalid' do
          expect(policy.success?).to be_falsey
        end

        it 'has errors' do
          expect(policy.errors[:status].any?).to be_truthy
        end
      end
    end
  end
end
