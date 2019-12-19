require "json"
require "faraday"

class MarvelHttp
  DEFAULT_TIMEOUT = 3 #seconds

  def initialize
    @connection ||= Faraday.new(  
      url: ENV["MARVEL_ENDPOINT"],  
      params: MarvelAuth.authenticate,   
      headers: {'Content-Type' => 'application/json'},
      request: { timeout: DEFAULT_TIMEOUT }
    )
  end

  def fetch(endpoint, params = {})
    response = @connection.get(endpoint) do |request|
      params.each do |key, value|
        request.params[key] = value
      end
    end
    ResponseHandler.new(response)
  end
end