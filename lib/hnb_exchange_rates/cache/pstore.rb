require "pstore"

module HnbExchangeRates
  module Cache
    module PStore

      def self.get(stamp)
        pstore.transaction do
          pstore.fetch(stamp, nil)
        end
      end

      def self.set(stamp, data)
        pstore.transaction do
          pstore[stamp] = data
        end
      end


      private

      def self.pstore
        @@pstore ||= ::PStore.new("hnb_exhange_rates.pstore")
      end

    end
  end
end
