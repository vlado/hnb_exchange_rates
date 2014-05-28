require "test_helper"
require "hnb_exchange_rates/grabber"

class TestGrabber < Minitest::Test

  def setup
    sweep_cache
    stub_hnb_web_requests
    @grabber = HnbExchangeRates::Grabber.new
    @date = Date.parse("2014-05-10")
    @date_without_rates = Date.parse("2014-05-02")
  end

  def test_that_data_for_proper_date_is_grabbed
    data = @grabber.grab(@date)
    assert_equal "10052014", data["application_date"]
  end

  def test_that_proper_data_is_cached
    assert_nil HnbExchangeRates::Cache.get(@date)
    data = @grabber.grab(@date)
    assert_equal data, HnbExchangeRates::Cache.get(@date)
  end

  def test_that_latest_work_day_is_grabbed_for_date_without_rates
    data = @grabber.grab(@date_without_rates)
    assert_equal "01052014", data["application_date"]
  end

  def test_that_latest_work_day_data_is_cached_for_date_without_rates
    assert_nil HnbExchangeRates::Cache.get(@date_without_rates)
    data = @grabber.grab(@date_without_rates)
    assert_equal data, HnbExchangeRates::Cache.get(@date_without_rates)
  end

end
