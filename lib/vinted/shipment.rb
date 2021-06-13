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
      @date ||= Time.strptime(splitted_string[0], DATE_TIME_FORMAT)
    end
    alias_method :date, :shipment_date

    def shipment_month
      @month ||= shipment_date.month
    end
    alias_method :month, :shipment_month

    def shipping_size
      @shipping_size ||= splitted_string[1]
    end
    alias_method :size, :shipping_size

    def shipping_provider
      @provider ||= splitted_string[2]
    end
    alias_method :provider, :shipping_provider

    def shipment_cost
      @cost ||= ShipmentCost.new(self).cost
    end
    alias_method :cost, :shipment_cost

    private

    def splitted_string
      splitted_string ||= str.split(' ')
    end
  end
end
