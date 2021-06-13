require_relative "./shipment_cost"

module Vinted
  class ShipmentsProcessor

    MAX_DISCOUNT = 10.00

    def self.min_cost_for_size(size:)
      costs = []
      Vinted::ShipmentCost::DEFAULT_SHIPPING_COSTS.each do |provider, shipping_charges|
        costs << shipping_charges[size.to_sym]
      end
      costs.min
    end


  end
end
