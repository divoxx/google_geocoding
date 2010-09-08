module GoogleGeocoding
  # Model that represents a placemark returned by the geocoding service.
  class Result
    REQUIRED_ATTRIBUTES = [:types, :address, :coordinates, :precision].freeze
    attr_reader :components, *REQUIRED_ATTRIBUTES
    
    def initialize(args = {})
      process_args(args)
      @components = Hash.new { |h,k| h[k] = [] }
    end
    
    def <<(component)
      component.types.each do |type|
        @components[type.to_sym] << component
      end
    end
    
    def get(type)
      @components[type.to_sym]
    end
    
    def each(&block)
      @component.each(&block)
    end
    
  private
    def process_args(args)
      error = Errors::InvalidParametersError.new(self)
      
      REQUIRED_ATTRIBUTES.each do |req_attr|
        error.add(req_attr, :required) unless args.include?(req_attr)
      end
      
      raise error unless error.empty?
      
      @types       = Array(args[:types]).map { |type| type.to_sym }.freeze
      @address     = args[:address].freeze
      @coordinates = args[:coordinates].freeze
      @precision   = args[:precision].downcase.to_sym
    end
  end
end