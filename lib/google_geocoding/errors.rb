module GoogleGeocoding
  module Errors
    # Error representing that the parameters provided to the request are invalid.
    class InvalidParametersError < BaseError
      def initialize(request)
        @request  = request
        @messages = Hash.new { |h,k| h[k] = [] }
      end

      # Add a error message for the given param.
      def add(param, identifier)
        @messages[param] << identifier
      end

      # Returns the messages for the given param
      def on(param)
        @messages[param]
      end

      # Returns a descriptive message of the error.
      def message
        message = "Some of the request parameters are invalid:"      
        @messages.each { |param, identifiers|  message << "\n  * #{param}: #{identifiers.join(', ')}" }
        message
      end

      # Alias to_s to messages for easy terminal output
      alias_method :to_s, :message

      # Returns true/false for whether there are an error on any params
      def empty?
        @messages.empty?
      end
    end
    
    # Http error, will be raised when the server returns with a status code outside the 200...300 range.
    class HttpError < BaseError
      def initialize(address, response)
        @address  = address
        @response = response
        super "Could not geocode '#{@address}'. Server responded with #{@response.status}"
      end
    end
  end
end