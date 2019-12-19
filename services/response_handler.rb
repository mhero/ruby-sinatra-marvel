class ResponseHandler
  def initialize(response)
    @response = response
    @body = JSON.parse(@response.body, symbolize_names: true)
  end

  def success?
    @response.status == 200 && !empty_response?
  end

  def handle
    if success?
      successful_response[:results]
    else
      error_response(custom_response_code || @response.status)
    end
  end

  private

  def custom_response_code
    404 if empty_response?
  end

  def empty_response?
    @body[:data][:results].empty?
  end

  def error_response(error_code)
    {
      body: @body,
      results: [],
      status: error_code
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