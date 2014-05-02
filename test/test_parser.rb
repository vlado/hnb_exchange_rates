require "minitest/autorun"
require "hnb_exchange_rates/parser"

class TestParser < Minitest::Test

  def setup
    parser = HnbExchangeRates::Parser.new
    @data = parser.parse(File.open("test/fixtures/100414.dat", "r").read)
  end

  def test_that_proper_metadata_is_returned
    assert_equal "070", @data[:code]
    assert_equal "09042014", @data[:creation_date]
    assert_equal "10042014", @data[:application_date]
    assert_equal 13, @data[:rates_count]
  end

  def test_that_proper_rates_are_returned
    assert_equal 13, @data[:rates].size

    assert_equal 5.174364, @data[:rates]["AUD"][:buying]
    assert_equal 5.189934, @data[:rates]["AUD"][:middle]
    assert_equal 5.205504, @data[:rates]["AUD"][:selling]

    assert_equal 2.500724, @data[:rates]["HUF"][:buying]
    assert_equal 2.508249, @data[:rates]["HUF"][:middle]
    assert_equal 2.515774, @data[:rates]["HUF"][:selling]
  end
end
