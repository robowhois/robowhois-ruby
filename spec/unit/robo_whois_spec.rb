require 'spec_helper'

describe RoboWhois do
  let(:client) { RoboWhois.new('API_KEY') }

  describe "#initialize" do
    it "sets api_key" do
      client.api_key.should == 'API_KEY'
    end
  end

  describe "#request" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/account', 'account')
    end

    it "sets authentication credentials" do
      RoboWhois.should_receive(:get).with('/account', hash_including(:basic_auth => {
          :username => "API_KEY",
          :password => "X",
      }))
      client.account
    end

    it "sets headers" do
      RoboWhois.should_receive(:get).with('/account', hash_including(:headers => {
          "User-Agent" => "RoboWhois Ruby #{RoboWhois::VERSION}"
      }))
      client.account
    end
  end

  describe "#account" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/account', 'account')
      @response = client.account
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns account information" do
      @response.should be_a(Hash)
      @response['account']['id'].should == '000000000000000000000000'
      @response['account']['email'].should == 'example@example.com'
      @response['account']['api_token'].should == '0000000000000000000000000000000000000000'
      @response['account']['credits_remaining'].should == 499
    end
  end

  describe "#whois" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/whois/example.com', 'whois')
      @response = client.whois("example.com")
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns the raw whois record" do
      @response.should be_a(String)
      @response.should =~ /^\nWhois Server Version 2.0/
    end
  end

  describe "#whois_availability" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/whois/example.com/availability', 'whois_availability')
      @response = client.whois_availability("example.com")
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns whois availability" do
      @response.should be_a(Hash)
      @response['response']['daystamp'].should == '2012-02-11'
      @response['response']['available'].should == false
      @response['response']['registered'].should == true
    end
  end

  describe "#whois_parts" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/whois/example.com/parts', 'whois_parts')
      @response = client.whois_parts("example.com")
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns whois record parts" do
      @response.should be_a(Hash)
      @response['response']['daystamp'].should == '2012-02-11'
      @response['response']['parts'].size.should == 2

      part = @response['response']['parts'][0]
      part['host'].should == 'whois.crsnic.net'
      part['body'].should =~ /^\nWhois Server Version 2.0/

      part = @response['response']['parts'][1]
      part['host'].should == 'whois.iana.org'
      part['body'].should =~ /^% IANA WHOIS server/
    end
  end

  describe "#whois_properties" do
    before do
      stub_get('http://API_KEY:X@api.robowhois.com/whois/example.com/properties', 'whois_properties')
      @response = client.whois_properties("example.com")
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns whois properties" do
      @response.should be_a(Hash)
      @response['response']['daystamp'].should == '2012-02-11'
      @response['response']['properties'].should be_a(Hash)

      properties = @response['response']['properties']
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
      stub_get('http://API_KEY:X@api.robowhois.com/whois/example.com/record', 'whois_record')
      @response = client.whois_record("example.com")
    end

    it "responds with 200" do
      @response.code.should == 200
    end

    it "returns whois record" do
      @response.should be_a(Hash)
      @response['response']['daystamp'].should == '2012-02-11'
      @response['response']['record'].should =~ /^\nWhois Server Version 2.0/
    end
  end

end
