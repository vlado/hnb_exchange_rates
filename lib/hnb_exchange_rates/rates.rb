require "hnb_exchange_rates/data"
require "hnb_exchange_rates/grabber"

module HnbExchangeRates
  class Rates
    CURRENCY_CODES = %w(AUD CAD CZK DKK HUF JPY NOK SEK CHF GBP USD EUR PLN)
    RATE_TYPES = [:middle, :buying, :selling]

    class InvalidCurrencyError < StandardError; end;
    class InvalidRateTypeError < StandardError; end;

    attr_reader :date

    def initialize(date)
      @date = date
    end

    def data
      @data ||= get_data
    end

    def exchange_rate(currency, rate_type = :middle)
      curr_code = currency.to_s.upcase

      raise_if_currency_is_invalid(curr_code)
      raise_if_rate_type_is_invalid(rate_type)

      rates = data.rates[curr_code.to_s]
      xrate = rates[rate_type.to_s]

      round(xrate / rates["unit"])
    end


    private

    def get_data
      raw_data = HnbExchangeRates::Grabber.new.grab(@date)
      HnbExchangeRates::Data.new(raw_data)
    end

    def raise_if_currency_is_invalid(currency)
      return if CURRENCY_CODES.include?(currency)

      raise(
        InvalidCurrencyError,
        "#{currency} is invalid currency. Supported currencies are: #{CURRENCY_CODES.join(', ')}"
      )
    end

    def raise_if_rate_type_is_invalid(rate_type)
      return if RATE_TYPES.include?(rate_type)

      raise(
        InvalidRateTypeError,
        "#{rate_type} is invalid. Supported rate_types are: #{RATE_TYPES.join(', ')}"
      )
    end

    def round(number, precision = 8)
      (number * 10**precision).round.to_f / 10**precision
    end

  end
end
