require_relative "./invalid_shipment_discount_printer"
require_relative "./shipment_cost"
require_relative "./shipments_discount_calculator"
require_relative "./shipment_discount_printer"

module Vinted
  class ShipmentsProcessor

    MAX_DISCOUNT = 10.00

    attr_accessor :result

    def initialize(shipments:)
      @shipments = shipments
      @result = {}
    end

    def process
      process_valid_shipments
      process_invalid_shipments
      print_result
    end

    private

    def print_result
      @shipments.each do |shipment|
        puts result[shipment.object_id.to_s].print_string
      end
    end

    def valid_shipments
      @valid_shipments ||= @shipments.select(&:valid?)
    end

    def invalid_shipments
      @invalid_shipments ||= @shipments.reject(&:valid?)
    end

    def process_valid_shipments
      return unless valid_shipments
      discount_calculator = Vinted::ShipmentsDiscountCalculator.new
      valid_shipments.each { |shipment| discount_calculator.add_shipment(shipment) }
      discount_calculator.process
      valid_shipments.each do |shipment|
        discount = discount_calculator.discount_for(shipment)
        @result[shipment.object_id.to_s] = Vinted::ShipmentDiscountPrinter.new(shipment: shipment, discount: discount)
      end
    end

    def process_invalid_shipments
      return unless invalid_shipments
      invalid_shipments.each do |shipment|
        @result[shipment.object_id.to_s] = Vinted::InvalidShipmentDiscountPrinter.new(shipment: shipment)
      end
    end

  end
end
