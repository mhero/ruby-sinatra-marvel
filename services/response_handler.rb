class ResponseHandler
  def initialize(response)
    @response = response
    unless  response.nil?
      @body = JSON.parse(@response.body, symbolize_names: true) 
    end
  end

  def response_ok?
    @response.status == 200
  end

  def success?
    [@response, @body].all? && response_ok? && !response_with_empty_data?
  end

  def response_with_empty_data?
    @body[:data][:results].empty?
  end

  def handle(klass)
    if success?
      @body[:data][:results].map do |object|
        klass.new(object)
      end
    elsif response_ok? && response_with_empty_data?
      error_response(404, "No data returned")
    else
      error_response(500, "Something went wrong on Marvel API")
    end
  end

  private

  def error_response(status, meesage)
    {
      message: meesage,
      status: status
    }
  end
end