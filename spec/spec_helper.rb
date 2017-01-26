require 'vcr'
require 'vcr-gzip'

RSpec.configure do |config|
  tmp_dir = File.expand_path('../../tmp/cassette_library_dir', __FILE__)
  config.before(:each) do
    VCR.configuration.cassette_library_dir = tmp_dir
  end

  config.after(:each) do
    FileUtils.rm_rf tmp_dir
  end
end