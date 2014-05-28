require "minitest/autorun"
require "hnb_exchange_rates/parser"

class TestParser < Minitest::Test

  def setup
    parser = HnbExchangeRates::Parser.new
    @data = parser.parse(File.open("test/fixtures/dat/2014-05-10.dat", "r").read)
  end

  def test_that_proper_metadata_is_returned
    assert_equal "090", @data["code"]
    assert_equal "09052014", @data["creation_date"]
    assert_equal "10052014", @data["application_date"]
    assert_equal 13, @data["rates_count"]
  end

  def test_that_proper_rates_are_returned
    assert_equal 13, @data["rates"].size

    assert_equal 5.129686, @data["rates"]["AUD"]["buying"]
    assert_equal 5.145121, @data["rates"]["AUD"]["middle"]
    assert_equal 5.160556, @data["rates"]["AUD"]["selling"]

    assert_equal 2.490838, @data["rates"]["HUF"]["buying"]
    assert_equal 2.498333, @data["rates"]["HUF"]["middle"]
    assert_equal 2.505828, @data["rates"]["HUF"]["selling"]
  end
end
