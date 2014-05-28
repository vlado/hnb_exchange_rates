require "test_helper"
require "hnb_exchange_rates/rates"

class TestRates < Minitest::Test

  def setup
    sweep_cache
    stub_hnb_web_requests
    @date = Date.parse("2014-05-10")
    @rates = HnbExchangeRates::Rates.new(@date)
  end

  def test_that_data_is_of_proper_type
    assert_instance_of HnbExchangeRates::Data, @rates.data
  end

  def test_that_data_is_memoized
    data_first = @rates.data
    data_second = @rates.data

    assert_equal data_first, data_second
    assert_equal data_first.object_id, data_second.object_id
  end

  def test_that_date_matches
    assert_equal @date, @rates.date
  end

  def test_that_exchange_rate_returns_middle_rate_by_default
    assert_equal 5.145121, @rates.exchange_rate("AUD")
  end

  def test_that_exchange_rate_returns_proper_rate_type
    assert_equal 5.145121, @rates.exchange_rate("AUD", :middle)
    assert_equal 5.129686, @rates.exchange_rate("AUD", :buying)
    assert_equal 5.160556, @rates.exchange_rate("AUD", :selling)
  end

  def test_exchange_rate_when_currency_unit_is_100
    assert_equal 0.02498333, @rates.exchange_rate("HUF")
    assert_equal 0.02490838, @rates.exchange_rate("HUF", :buying)
    assert_equal 0.02505828, @rates.exchange_rate("HUF", :selling)
    assert_equal 0.05395844, @rates.exchange_rate("JPY")
  end

  def test_that_exchange_rate_raises_if_currency_is_invalid
    assert_raises HnbExchangeRates::Rates::InvalidCurrencyError do
      @rates.exchange_rate("BAM")
    end
  end

  def test_that_exchange_rate_raises_if_rate_type_is_invalid
    assert_raises HnbExchangeRates::Rates::InvalidRateTypeError do
      @rates.exchange_rate("AUD", :wrong)
    end
  end
end
