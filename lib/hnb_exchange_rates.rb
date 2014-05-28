require "hnb_exchange_rates/configuration"
require "hnb_exchange_rates/rates"
require "hnb_exchange_rates/version"

module HnbExchangeRates

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= HnbExchangeRates::Configuration.new
    yield(configuration)
  end

  def self.on(date)
    HnbExchangeRates::Rates.new(date)
  end

end
