module RspecSupportFakeRequestHelpers
  def stub_get(url, name)
    FakeWeb.register_uri(:get, url, :response => File.read("#{fixture(name)}.dump"))
  end
end

RSpec.configure do |config|
  config.include RspecSupportFakeRequestHelpers
end
