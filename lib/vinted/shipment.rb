require 'time'
module Vinted
  class  Shipment
    MATCH_REGEXP = /\d\d\d\d-\d\d\-\d\d\ [SLM] (MR|LP)/
    DATE_TIME_FORMAT = '%Y-%m-%d'

    attr_reader :str
    def initialize(str)
      @str = str
    end

    def valid?
      valid_date? && str.match(MATCH_REGEXP).to_s === str
    end

    def shipment_date
      return nil unless valid?
      @shipment_date ||= Time.strptime(splitted_string[0], DATE_TIME_FORMAT)
    end

    def shipping_size
      return nil unless valid?
      splitted_string[1]
    end

    def shipping_provider
      return nil unless valid?
      splitted_string[2]
    end

    private

    def valid_date?(format = DATE_TIME_FORMAT )
      Time.strptime(splitted_string[0], DATE_TIME_FORMAT) rescue false
    end

    def splitted_string
      @splitted_string ||= str.split(' ')
    end
  end
end
