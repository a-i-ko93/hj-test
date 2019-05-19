class AdImporter
  CAMPAIGN_URL = 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'.freeze

  def self.execute
    begin
      response = HTTParty.get(CAMPAIGN_URL, format: :plain)
      parsed_response = JSON.parse(response, symbolize_names: true).fetch(:ads)
    rescue => e
      []
    else
      parsed_response
    end
  end
end
