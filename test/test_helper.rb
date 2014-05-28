require "minitest/autorun"
require "webmock/minitest"
require "hnb_exchange_rates"

HnbExchangeRates.configure do |config|
  config.cache_store = HnbExchangeRates::Cache::File
  config.cache_dir = File.join(File.dirname(__FILE__), "tmp", "cache")
end

module HnbExchangeRates
  module TestHelpers

    def stub_hnb_web_requests
      require "addressable/template"
      fixtures_root = File.join(File.dirname(__FILE__), "fixtures", "responses")
      uri_template = Addressable::Template.new("www.hnb.hr/tecajn/f{stamp}.dat")
      stub_request(:get, uri_template).to_return do |request|
        stamp = request.uri.to_s.scan(/f(\d+)\.dat\Z/).flatten.first
        file_name = Date.strptime(stamp, "%d%m%y").to_s
        path = File.join(fixtures_root, file_name)
        if !File.exist?(path)
          `curl -is curl -is http://hnb.hr/tecajn/f#{stamp}.dat > #{path}`
        end
        File.new(path)
      end
    end

    def sweep_cache
      require "fileutils"
      path = HnbExchangeRates.configuration.cache_dir
      FileUtils.mkdir_p(path)
      FileUtils.remove_entry_secure(path)
      FileUtils.mkdir_p(path)
    end

  end
end

Minitest::Test.send(:include, HnbExchangeRates::TestHelpers)
