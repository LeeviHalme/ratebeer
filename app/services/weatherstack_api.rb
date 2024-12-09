class WeatherstackApi
  def self.weather_in(city)
    url = "http://api.weatherstack.com/current"

    response = HTTParty.get "#{url}?query=#{ERB::Util.url_encode(city)}&access_key=#{key}"

    if response.code == 404
      return []
    end

    response.parsed_response
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
