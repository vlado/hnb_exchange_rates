module HnbExchangeRates
  class Parser

    def parse(raw_data)
      raw_data_array = raw_data.split("\n").map(&:strip)
      header = raw_data_array.shift
      {
        "application_date" => header[11,8],
        "code" => header[0,3],
        "creation_date" => header[3,8],
        "rates_count" => header[19,2].to_i,
        "rates" => rates_hash_from_raw_data_array(raw_data_array)
      }
    end


    private

    def rates_hash_from_raw_data_array(items)
      hash = {}
      items.each do |item|
        rates = rates_hash_from_raw_item(item)
        hash[rates.delete("code")] = rates
      end
      hash
    end

    def rates_hash_from_raw_item(item)
      item_array = item.gsub(/\s+/, " ").split(" ")
      {
        "code" => item_array[0][3,3],
        "unit" => item_array[0][6,3].to_i,
        "buying" => string_to_number(item_array[1]),
        "middle" => string_to_number(item_array[2]),
        "selling" => string_to_number(item_array[3])
      }
    end

    def string_to_number(str)
        str.gsub(",", ".").to_f
    end

  end
end
