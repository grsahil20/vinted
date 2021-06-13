module Vinted
  class  ShipmentDiscountPrinter

    attr_reader :shipment, :discount

    def initialize(shipment:, discount:)
      @shipment = shipment
      @discount = discount
    end

    def print_string
      [shipment.str, final_price, discount].join(" ")
    end

    def final_price
      shipment.cost - discount
    end

  end
end
