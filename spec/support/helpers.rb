module RSpecSupportHelpers

  # Gets the currently described class.
  # Conversely to +subject+, it returns the class
  # instead of an instance.
  def klass
    described_class
  end

  def fixture(*names)
    File.join(SPEC_ROOT, "fixtures", *names)
  end

end

RSpec.configure do |config|
  config.include RSpecSupportHelpers
end
