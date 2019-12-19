require "json"
require "faraday"

class MarvelHttp
  def initialize
    @connection ||= Faraday.new(  
      url: ENV["MARVEL_ENDPOINT"],  
      params: MarvelAuth.authenticate,   
      headers: {'Content-Type' => 'application/json'}
    )  
  end

  def fetch(endpoint, params = {})
    response = @connection.get(endpoint) do |req|
      params.each do |key, value|
        req.params[key] = value
      end
    end
    response_as_hash(response)
  end

  def response_as_hash(response)
    body = JSON.parse(response.body, symbolize_names: true)

    {
      body: body,
      results: body[:data][:results],
      status: response.status
    }
  end
end