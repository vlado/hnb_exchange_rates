require "date"
require_relative "hnb_exchange_rates/version"
require_relative "hnb_exchange_rates/rates"

module HnbExchangeRates

  def self.on(date)
    HnbExchangeRates::Rates.new(date)
  end

end
