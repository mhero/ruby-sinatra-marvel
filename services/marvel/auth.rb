require "digest"

module Marvel
  class Auth
    class << self 
      def authenticate
        # good neighbour calling it with real time
        timestamp = (Time.now).utc.strftime("%Y%m%d%H%M%S")

        {
          ts: timestamp,
          apikey: ENV["MARVEL_PUBLIC_KEY"],
          hash: md5_digest(timestamp)
        }
      end
      
      private

      def md5_digest(timestamp)
        Digest::MD5.hexdigest(timestamp + ENV["MARVEL_PRIVATE_KEY"] + ENV["MARVEL_PUBLIC_KEY"])
      end
    end
  end
end