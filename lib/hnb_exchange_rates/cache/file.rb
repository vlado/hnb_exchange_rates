require "json"

module HnbExchangeRates
  module Cache
    class File

      def self.get(date)
        path = path_for_date(date)
        if ::File.exist?(path)
          str = ::File.open(path, "r") { |f| f.read }
          JSON.parse(str)
        else
          nil
        end
      end

      def self.set(date, data)
        path = path_for_date(date)
        ::File.open(path, "w") { |f| f.write(data.to_json) }
      end


      private

      def self.path_for_date(date)
        key = date.strftime("%Y-%m-%d")
        ::File.join(HnbExchangeRates.configuration.cache_dir, "#{key}.json")
      end

    end
  end
end
