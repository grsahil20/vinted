require_relative "./invalid_shipment"
require_relative "./shipment"

require 'time'
module Vinted
  class ShipmentFactory

    VALID_STRING_REGEXP = /\d\d\d\d-\d\d\-\d\d\ [SLM] (MR|LP)/
    DATE_TIME_FORMAT = '%Y-%m-%d'.freeze

    attr_reader :str

    def initialize(str)
      @str = str
    end

    def shipment
      shipment_class.new(str)
    end

    private

    def valid_date?
      Time.strptime(str.split(' ')[0], DATE_TIME_FORMAT) rescue false
    end

    def valid_string?
      str.match(VALID_STRING_REGEXP).to_s == str
    end

    def shipment_class
      (valid_string? && valid_date?) ? Vinted::Shipment : Vinted::InvalidShipment
    end
  end
end
