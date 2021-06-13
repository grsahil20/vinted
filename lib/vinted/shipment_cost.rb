require 'time'
module Vinted
  class ShipmentCost

    DEFAULT_SHIPPING_COSTS = {
      LP: { S: 1.50, M: 4.90, L: 6.90 },
      MR: { S: 2.00, M: 3.00, L: 4.00 }
    }

    attr_reader :shipment

    def initialize(shipment)
      @shipment = shipment
    end

    def cost
      DEFAULT_SHIPPING_COSTS[shipment.shipping_provider.to_sym][shipment.shipping_size.to_sym]
    end
  end
end
