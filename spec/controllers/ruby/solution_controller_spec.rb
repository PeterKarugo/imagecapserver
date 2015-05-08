require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "SolutionController" do
  include_examples "SpecHelper"
	include Rack::Test::Methods
	include Rhoconnect

  def app
    @app = Rack::URLMap.new Rhoconnect.url_map
  end

  before(:each) do
    setup_test_for Solution,'testuser'
    # login user to establish session cookie before each test
    post "/rc/#{Rhoconnect::API_VERSION}/app/login", {"login" => 'testuser', "password" => ''}.to_json, {'CONTENT_TYPE'=>'application/json; charset=UTF-8'}
    last_response.status.should == 200
  end

  it "should process SolutionController GET" do
    pending
  end

  it "should process SolutionController POST" do
    pending
  end
end