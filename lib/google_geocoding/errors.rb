module GoogleGeocoding
  module Errors
    # Http error, will be raised when the server returns with a status code outside the 200...300 range.
    class HttpError < BaseError
      def initialize(address, response)
        @address  = address
        @response = response
        super "Could not geocode '#{@address}'. Server responded with #{@response.status}"
      end
    end
          
    # Services error means the service was reached but returned a unsuccessful response.
    class ServiceError < BaseError; end
    
    # 500 G_GEO_SERVER_ERROR
    class ServerError < ServiceError
      def initialize
        super("A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is unknown.")
      end
    end
    
    # 601 G_GEO_MISSING_QUERY
    class MissingQueryError < ServiceError
      def initialize
        super("An empty address was specified")
      end
    end

    # 602 G_GEO_UNKNOWN_ADDRESS
    class UnknownAddressError < ServiceError
      def initialize
        super("No corresponding geographic location could be found for the specified address, possibly because the address is relatively new, or because it may be incorrect.")
      end
    end
    
    # 603 G_GEO_UNAVAILABLE_ADDRESS
    class UnavailableAddressError < ServiceError
      def initialize
        super("The geocode for the given address or the route for the given directions query cannot be returned due to legal or contractual reasons.")
      end
    end
    
    # 610 G_GEO_BAD_KEY
    class BadKeyError < ServiceError
      def initialize
        super("The given key is either invalid or does not match the domain for which it was given.")
      end
    end
    
    # 620 G_GEO_TOO_MANY_QUERIES
    class TooManyQueriesError < ServiceError
      def initialize
        super("The given key has gone over the requests limit in the 24 hour period or has submitted too many requests in too short a period of time. If you're sending multiple requests in parallel or in a tight loop, use a timer or pause in your code to make sure you don't send the requests too quickly.")
      end
    end
    
    # Extend ServiceError to include factory method based on status codes.
    class ServiceError
      ERRORS_MAPPING = {
        500 => ServerError,
        601 => MissingQueryError,
        602 => UnknownAddressError,
        603 => UnknownAddressError,
        610 => BadKeyError,
        620 => TooManyQueriesError
      }
      
      def self.build(status)
        ERRORS_MAPPING[status].new
      end
    end
  end
end