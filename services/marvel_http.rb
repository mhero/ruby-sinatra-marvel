require "json"
require "faraday"

class MarvelHttp
  def initialize
    @auth ||= MarvelAuth.authenticate

    @connection ||= Faraday.new(  
      url: ENV["MARVEL_ENDPOINT"],  
      params: @auth,   
      headers: {'Content-Type' => 'application/json'}
    )  
  end

  def fetch(endpoint, params = {})
    response = @connection.get(endpoint) do |req|
      params.each do |key, value|
        req.params[key] = value
      end
    end 
  
    JSON.parse(
      response.body,
      symbolize_names: true
    )
  end
end