module HnbExchangeRates
  class Data

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def rates
      @attributes[:rates]
    end

  end
end
