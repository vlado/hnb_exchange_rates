require "hnb_exchange_rates/cache/file"
require "hnb_exchange_rates/cache/pstore"

module HnbExchangeRates
  module Cache

    def self.get(stamp)
      store.get(stamp)
    end

    def self.set(stamp, data)
      store.set(stamp, data)
    end

    def self.store
      @_store ||= HnbExchangeRates.configuration.cache_store
    end

  end
end
