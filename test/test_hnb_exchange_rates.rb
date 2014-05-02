require "minitest/autorun"
require "webmock/minitest"
require "hnb_exchange_rates"

class TestHnbExchangeRates < Minitest::Test

  def setup
    @subject = HnbExchangeRates
  end

  def test_on
    rates = @subject.on(Date.today)
    assert_instance_of HnbExchangeRates::Rates, rates
    assert_equal Date.today, rates.date
  end
end
