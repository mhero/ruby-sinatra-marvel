class ResponseHandler
  def initialize(response)
    @response = response
    @body = JSON.parse(@response.body, symbolize_names: true)
  end

  def success?
    @response.status == 200
  end

  def handle
    if success?
      successful_response[:results]
    else
      error_response
    end
  end

  private

  def error_response
    {
      body: @body,
      results: [],
      status: @response.status
    }
  end

  def successful_response
    {
      body: @body,
      results: @body[:data][:results],
      status: @response.status
    }
  end
end