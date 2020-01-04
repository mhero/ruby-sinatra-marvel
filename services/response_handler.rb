class ResponseHandler
  NOT_FOUND = 404
  SERVER_ERROR = 500
  SUCCESS = 200
  REQUEST_ERROR = (400..499).freeze

  def initialize(response)
    @status = response&.status
    @body = JSON.parse(response&.body, symbolize_names: true) 
  end

  def bad_request?
    REQUEST_ERROR.include? @status
  end

  def success?
    @status == SUCCESS && !response_with_empty_data?
  end

  def response_with_empty_data?
    @body.fetch(:data, {}).fetch(:results, {}).empty?
  end

  def handle(klass)
    if success?
      @body[:data][:results].map do |object|
        object[:attribution_text] = @body[:attributionText]
        klass.new(object)
      end
    elsif response_with_empty_data? || bad_request?
      Fault.new NOT_FOUND
    else
      Fault.new SERVER_ERROR
    end
  end
end