require 'time'
module Vinted
  class  Shipment

    DATE_TIME_FORMAT = '%Y-%m-%d'

    attr_reader :str
    def initialize(str)
      @str = str
    end

    def valid?
      true
    end

    def shipment_date
      @shipment_date ||= Time.strptime(splitted_string[0], DATE_TIME_FORMAT)
    end

    def shipping_size
      @shipping_size ||= splitted_string[1]
    end

    def shipping_provider
      @shipping_provider ||= splitted_string[2]
    end

    def shipment_cost
      @shipment_cost ||= ShipmentCost.new(self).cost
    end

    def print
      str
    end

    private

    def splitted_string
      @splitted_string ||= str.split(' ')
    end
  end
end
