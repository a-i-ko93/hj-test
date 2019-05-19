class AdPolicy
  include Hanami::Validations

  STATUSES = %w[active paused deleted].freeze

  validations do
    required(:reference) { filled? }
    required(:ad_description) { filled? }
    required(:status) { filled? & included_in?(STATUSES) }
  end
end
