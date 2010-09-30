require File.expand_path("../spec_helper", __FILE__)

describe "Full-stack geocoding (Integration test)" do
  before :each do
    @geocoder = GoogleGeocoding::Geocoder.new(:language => "pt_BR")
  end
  
  it "should return successful response with valida address" do
    response = @geocoder.query("2 Townsend St, San Francisco, CA")
    response.status.should be(:ok)
    response.should be_success
  end
  
  it "should allow passing options to the request" do
    orig_constructor = GoogleGeocoding::Request.method(:new)
    
    GoogleGeocoding::Request.should_receive(:new) do |opts|
      opts.should have_key(:language)
      orig_constructor.call(opts)
    end
    
    @geocoder.query("2 Townsend St, San Francisco, CA")
  end
end