module Vinted
  class InvalidShipmentDiscountPrinter

    attr_reader :shipment

    def initialize(shipment:)
      @shipment = shipment
    end

    def print_string
      [shipment.str, 'Ignore'].join(" ")
    end
  end
end
