require "date"
require "open-uri"
require "hnb_exchange_rates/cache"
require "hnb_exchange_rates/parser"

module HnbExchangeRates
  class Grabber

    def grab(date)
      data = nil
      5.times do |i|
        xdate = date - i
        data = get_from_cache(xdate) || get_from_web(xdate)
        break if data
      end
      # TODO: only set cache if not pulled from cache
      HnbExchangeRates::Cache.set(date, data)
      data
    end


    private

    def get_from_cache(date)
      HnbExchangeRates::Cache.get(date)
    end

    def get_from_web(date)
      stamp = date.strftime("%d%m%y")
      response = open("http://www.hnb.hr/tecajn/f#{stamp}.dat").read
      parser.parse(response)
    rescue OpenURI::HTTPError => e
      nil
    end

    def parser
      @parser ||= HnbExchangeRates::Parser.new
    end

  end
end

