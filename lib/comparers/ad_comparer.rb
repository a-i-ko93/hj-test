class AdComparer
  COMPARED_ATTRIBUTES = %i[status ad_description].sort.freeze

  def initialize(local, remote)
    @local = local
    @remote = AdPolicy.new(remote)
    @validated_remote = @remote.validate
  end

  def execute
    {
      remote_reference: @local.external_reference,
      discrepancies: get_discrepancies
    }
  end

  private

  def get_discrepancies
    COMPARED_ATTRIBUTES.map do |attr|
      {
        attr => {
          local: @local.public_send(attr),
          remote: @remote.to_h[attr]
        }.tap do |base|
          error = @validated_remote.errors[attr]&.first
          base[:remote_note] = error if error
        end
      }
    end
  end
end
