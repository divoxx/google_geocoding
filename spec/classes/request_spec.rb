require File.expand_path("../../spec_helper", __FILE__)

describe Request do
  describe "request creation" do
    it "should create a request with valid params" do
      lambda { Request.new(:address => "2 Townsend St, San Francisco, CA", :sensor => false) }.should_not raise_error(Errors::InvalidParametersError)
    end
  
    it "should raise InvalidRequestParametersError when address is missing" do
      lambda { Request.new }.should raise_error(Errors::InvalidParametersError) do |error|
        error.on_param(:address).should include(:required)
        error.on_param(:sensor).should include(:required)
      end
    end
  end
  
  describe "request usage" do  
    before :each do
      @request = Request.new(:address => "2 Townsend St, San Francisco, CA", :sensor => false)
    end
    
    it "should return the query string" do
      @request.query_string.should == "address=2+Townsend+St%2C+San+Francisco%2C+CA&sensor=false"
    end
  end
end