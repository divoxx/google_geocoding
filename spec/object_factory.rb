module ObjectFactory
  class Factory
    def initialize
      @builders = {}
      yield self
    end

    def define(name, &block)
      @builders[name] = block
    end
  
    def create(name, *args)
      @builders[name].call(*args)
    end
  end
  
  module HelperMethods
    def factory_instance
      @factory ||= ObjectFactory::Factory.new do |f|
        f.define :request do |params|
          params = {:address => "2 Townsend St, San Francisco, CA", :sensor => false}.merge(params)
          GoogleGeocoding::Request.new(params)
        end
      end
    end
    
    def factory(*args)
      factory_instance.create(*args)
    end
  end
end