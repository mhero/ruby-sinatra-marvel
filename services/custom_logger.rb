module CustomLogger
  class Log
    @logger ||= Logger.new(STDOUT)

    class << self 
      def error_message_400(response)
        @logger.error  "#{response[:method].to_s.upcase} \
                        #{response[:url].to_s}: #{response[:status]} \
                        #{error_body(response[:body])}"
      end

      def error_body(body)
        if !body.nil? && !body.empty? && body.kind_of?(String)
          body = ::JSON.parse(body)
        end
      end

      def error_message_500(response)
        body = "Something in Marvel service is wrong."
        @logger.error  "#{response[:method].to_s.upcase} \
                        #{response[:url].to_s}: \
                        #{[response[:status].to_s + ':', body].compact.join(' ')}"
      end

      def timeout
        @logger.error "Marvel timeout produced"
      end

      def info(response)
        @logger.info  "#{response[:method].to_s.upcase} \
                       #{response[:url].to_s}: #{response[:status]}"
      end
    end
  end
end
