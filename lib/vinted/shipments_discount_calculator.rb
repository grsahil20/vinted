require_relative "./shipment_cost"

module Vinted
  class ShipmentsDiscountCalculator

    attr_accessor :shipments, :result

    def initialize(shipments:)
      @shipments = shipments
      @result = {}
    end

    def process
      init_size_based_minimum_pricings
      init_monthly_shipment_tracker
      calculate_discounts
    end

    def discount_for(shipment)
      @result[shipment.object_id.to_s]
    end

    private

    def calculate_discounts
      shipments.each do |shipment|
        discount = caluculate_shiping_discount(shipment)
        @result[shipment.object_id.to_s] = discount
      end
    end

    def caluculate_shiping_discount(shipment)
      case shipment.size
      when "S"
        size_s_based_discount(shipment)
      when "L"
        size_l_based_discount(shipment)
      else
        0.0
      end
    end

    def size_s_based_discount(shipment)
      minimum_pricings_based_discount(shipment, shipment.size.to_sym)
    end


    def minimum_pricings_based_discount(shipment, size)
      size_based_minimum_price = @size_based_minimum_pricings[size]
      return 0.0 if shipment.cost < size_based_minimum_price
      shipment.cost - size_based_minimum_price
    end

    def init_size_based_minimum_pricings
      pricings = {}
      Vinted::ShipmentCost::DEFAULT_SHIPPING_COSTS.each do |shipping_provider, shipping_pricings|
        shipping_pricings.each do |size, pricing|
          pricings[size] = [pricings[size], pricing].compact.min
        end
      end
      @size_based_minimum_pricings = pricings
    end

    def init_monthly_shipment_tracker
      @monthly_shipment_counts_tracker = {}
      shipment_months.each do |month|
        @monthly_shipment_counts_tracker[month.to_s] = 0
      end
    end

    def shipment_months
      shipments.map {|s| s.month}.uniq
    end

    def size_l_based_discount(shipment)
      return 0.0 unless shipment.provider == 'LP'
      @monthly_shipment_counts_tracker[shipment.month.to_s] = @monthly_shipment_counts_tracker[shipment.month.to_s].to_i + 1
      return 0.0 unless @monthly_shipment_counts_tracker[shipment.month.to_s] == 3
      shipment.cost
    end
  end
end
