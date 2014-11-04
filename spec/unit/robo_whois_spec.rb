require 'spec_helper'

describe RoboWhois do
  let(:client) { RoboWhois.new(:api_key => 'API_KEY') }

  describe "#initialize" do
    it "sets api_key from argument" do
      client = RoboWhois.new(:api_key => 'API_KEY')
      expect(client.api_key).to eq('API_KEY')
    end

    it "sets api_key from environment" do
      ENV['ROBOWHOIS_API_KEY'] = 'ENV_KEY'
      client = RoboWhois.new
      expect(client.api_key).to eq('ENV_KEY')
      ENV.delete('ROBOWHOIS_API_KEY')
    end

    it "raises if no api_key is set" do
      expect { RoboWhois.new }.to raise_error(ArgumentError, "Missing API key")
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
      stub_get('https://API_KEY:X@api.robowhois.com/v1/account', 'account')
    end

    it "sets authentication credentials" do
      expect(RoboWhois).to receive(:get).with('/account', hash_including(:basic_auth => {
          :username => "API_KEY",
          :password => "X",
      })).and_return(mock_response)
      client.account
    end

    it "sets headers" do
      expect(RoboWhois).to receive(:get).with('/account', hash_including(:headers => {
          "User-Agent" => "robowhois-ruby/#{RoboWhois::VERSION}"
      })).and_return(mock_response)
      client.account
    end
  end

  describe "#account" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/account', 'account')
      @response = client.account
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns account information" do
      expect(@response).to be_a(Hash)
      expect(@response['id']).to eq('000000000000000000000000')
      expect(@response['email']).to eq('example@example.com')
      expect(@response['api_token']).to eq('0000000000000000000000000000000000000000')
      expect(@response['credits_remaining']).to eq(499)
    end
  end

  describe "#whois" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/whois/example.com', 'whois')
      @response = client.whois("example.com")
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns the raw whois record" do
      expect(@response).to be_a(String)
      expect(@response).to match(/^\nWhois Server Version 2.0/)
    end
  end

  describe "#whois_parts" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/whois/example.com/parts', 'whois_parts')
      @response = client.whois_parts("example.com")
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns whois record parts" do
      expect(@response).to be_a(Hash)
      expect(@response['daystamp']).to eq('2012-02-11')
      expect(@response['parts'].size).to eq(2)

      part = @response['parts'][0]
      expect(part['host']).to eq('whois.crsnic.net')
      expect(part['body']).to match(/^\nWhois Server Version 2.0/)

      part = @response['parts'][1]
      expect(part['host']).to eq('whois.iana.org')
      expect(part['body']).to match(/^% IANA WHOIS server/)
    end
  end

  describe "#whois_properties" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/whois/example.com/properties', 'whois_properties')
      @response = client.whois_properties("example.com")
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns whois properties" do
      expect(@response).to be_a(Hash)
      expect(@response['daystamp']).to eq('2012-02-11')
      expect(@response['properties']).to be_a(Hash)

      properties = @response['properties']
      expect(properties['disclaimer']).to match(/^TERMS OF USE/)
      expect(properties['domain']).to eq('google.com')
      expect(properties['domain_id']).to be_nil
      expect(properties['available?']).to be_falsey
      expect(properties['registered?']).to be_truthy
      expect(properties['registrar']).to be_a(Hash)
    end
  end

  describe "#whois_record" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/whois/example.com/record', 'whois_record')
      @response = client.whois_record("example.com")
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns whois record" do
      expect(@response).to be_a(Hash)
      expect(@response['daystamp']).to eq('2012-02-11')
      expect(@response['record']).to match(/^\nWhois Server Version 2.0/)
    end
  end

  describe "#availability" do
    before do
      stub_get('https://API_KEY:X@api.robowhois.com/v1/availability/example.com', 'availability')
      @response = client.availability("example.com")
    end

    it "responds with 200" do
      expect(client.last_response.code).to eq(200)
    end

    it "returns whois availability" do
      expect(@response).to be_a(Hash)
      expect(@response['available']).to be_falsey
    end
  end


  context "request failure" do
    describe "BadCredentials" do
      let(:client) { client = RoboWhois.new(:api_key => 'BAD_KEY') }

      before do
        stub_get('https://BAD_KEY:X@api.robowhois.com/v1/account', 'error_bad_credentials')
      end

      it "raises an APIError" do
        expect {
          client.account
        }.to raise_error(RoboWhois::APIError, /BadCredentials/)
      end
    end

    describe "ServerWhoisOnlyWeb" do
      before do
        stub_get('https://API_KEY:X@api.robowhois.com/v1/whois/example.com/record', 'error_whois_server_only_web')
      end

      it "raises an APIError" do
        expect {
          client.whois_record("example.com")
        }.to raise_error(RoboWhois::APIError, /WhoisServerOnlyWeb/)
      end
    end
  end

end
