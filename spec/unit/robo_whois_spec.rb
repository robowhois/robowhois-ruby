require 'spec_helper'

describe RoboWhois do
  let(:client) { RoboWhois.new(:api_key => 'API_KEY') }

  describe "#initialize" do
    it "sets api_key from argument" do
      client = RoboWhois.new(:api_key => 'API_KEY')
      client.api_key.should == 'API_KEY'
    end

    it "sets api_key from environment" do
      ENV['ROBOWHOIS_API_KEY'] = 'ENV_KEY'
      client = RoboWhois.new
      client.api_key.should == 'ENV_KEY'
      ENV.delete('ROBOWHOIS_API_KEY')
    end

    it "raises if no api_key is set" do
      lambda {
        RoboWhois.new
      }.should raise_error(ArgumentError, "Missing API key")
    end
  end

  describe "#request" do
    let(:mock_response) {
      Class.new(Object) do
        def code
          200
        end
        def [](key)
          nil
        end
      end.new
    }

    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/account', 'account')
    end

    it "sets authentication credentials" do
      RoboWhois.should_receive(:get).with('/account', hash_including(:basic_auth => {
          :username => "API_KEY",
          :password => "X",
      })).and_return(mock_response)
      client.account
    end

    it "sets headers" do
      RoboWhois.should_receive(:get).with('/account', hash_including(:headers => {
          "User-Agent" => "RoboWhois Ruby #{RoboWhois::VERSION}"
      })).and_return(mock_response)
      client.account
    end
  end

  describe "#account" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/account', 'account')
      @response = client.account
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns account information" do
      @response.should be_a(Hash)
      @response['id'].should == '000000000000000000000000'
      @response['email'].should == 'example@example.com'
      @response['api_token'].should == '0000000000000000000000000000000000000000'
      @response['credits_remaining'].should == 499
    end
  end

  describe "#whois" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com', 'whois')
      @response = client.whois("example.com")
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns the raw whois record" do
      @response.should be_a(String)
      @response.should =~ /^\nWhois Server Version 2.0/
    end
  end

  describe "#whois_availability" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com/availability', 'whois_availability')
      @response = client.whois_availability("example.com")
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns whois availability" do
      @response.should be_a(Hash)
      @response['daystamp'].should == '2012-02-11'
      @response['available'].should == false
      @response['registered'].should == true
    end
  end

  describe "#whois_parts" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com/parts', 'whois_parts')
      @response = client.whois_parts("example.com")
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns whois record parts" do
      @response.should be_a(Hash)
      @response['daystamp'].should == '2012-02-11'
      @response['parts'].size.should == 2

      part = @response['parts'][0]
      part['host'].should == 'whois.crsnic.net'
      part['body'].should =~ /^\nWhois Server Version 2.0/

      part = @response['parts'][1]
      part['host'].should == 'whois.iana.org'
      part['body'].should =~ /^% IANA WHOIS server/
    end
  end

  describe "#whois_properties" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com/properties', 'whois_properties')
      @response = client.whois_properties("example.com")
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns whois properties" do
      @response.should be_a(Hash)
      @response['daystamp'].should == '2012-02-11'
      @response['properties'].should be_a(Hash)

      properties = @response['properties']
      properties['disclaimer'].should   =~ /^TERMS OF USE/
      properties['domain'].should       == 'google.com'
      properties['domain_id'].should    == nil
      properties['available?'].should   == false
      properties['registered?'].should  == true
      properties['registrar'].should    be_a(Hash)
    end
  end

  describe "#whois_record" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com/record', 'whois_record')
      @response = client.whois_record("example.com")
    end

    it "responds with 200" do
      client.last_response.code.should == 200
    end

    it "returns whois record" do
      @response.should be_a(Hash)
      @response['daystamp'].should == '2012-02-11'
      @response['record'].should =~ /^\nWhois Server Version 2.0/
    end
  end

  context "request failure" do
    describe "BadCredentials" do
      let(:client) { client = RoboWhois.new(:api_key => 'BAD_KEY') }

      before do
        stub_get('http://BAD_KEY:X@api.robowhois.com/v1/account', 'error_bad_credentials')
      end

      it "raises an APIError" do
        lambda {
          client.account
        }.should raise_error(RoboWhois::APIError, /BadCredentials/)
      end
    end

    describe "ServerWhoisOnlyWeb" do
      before do
        stub_get('http://API_KEY:X@api.robowhois.com/v1/whois/example.com/record', 'error_whois_server_only_web')
      end

      it "raises an APIError" do
        lambda {
          client.whois_record("example.com")
        }.should raise_error(RoboWhois::APIError, /WhoisServerOnlyWeb/)
      end
    end
  end

end
