module GoogleGeocoding
  class AddressComponent
    REQUIRED_ATTRIBUTES = [:long_name, :short_name, :types].freeze
    attr_reader *REQUIRED_ATTRIBUTES
    
    def initialize(params)
      process_args(params)
    end
    
  private
    def process_args(args)
      error = Errors::InvalidParametersError.new(self)
      
      REQUIRED_ATTRIBUTES.each do |req_attr|
        error.add(req_attr, :required) unless args.include?(req_attr)
      end
      
      raise error unless error.empty?
      
      @types      = Array(args[:types]).map { |type| type.to_sym }.freeze
      @long_name  = args[:long_name].freeze
      @short_name = args[:short_name].freeze
    end    
  end
end