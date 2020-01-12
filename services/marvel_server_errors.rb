class MarvelServerErrors < Faraday::Middleware
  def call(env)
    @app.call(env).on_complete do |response|
      case response[:status].to_i
      when 400, 404, 429
        Error::Logger.error_message_400(response)
      when 500, 502, 503, 522, 504
        Error::Logger.error_message_500(response)
      end
    end
  end

  def initialize(app)
    super app
  end
end