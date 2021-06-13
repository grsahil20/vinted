require "vinted/shipment_factory"
require "vinted/invalid_shipment"
require "vinted/shipment"

describe Vinted::ShipmentFactory do
  describe ".shipment" do
    context "when provided invalid string" do
      it "returns Invalid Shipment instance" do
        expect(Vinted::ShipmentFactory.new("aaaa").shipment.class).to eq(Vinted::InvalidShipment)
        expect(Vinted::ShipmentFactory.new("2015-02-29 CUSPS").shipment.class).to eq(Vinted::InvalidShipment)
      end
    end
    context "when provided invalid date in string" do
      it "returns Invalid Shipment instance" do
        expect(Vinted::ShipmentFactory.new("2015-22-10 L LP").shipment.class).to eq(Vinted::InvalidShipment)
      end
    end
    context "when provided invalid size in string" do
      it "returns Invalid Shipment instance" do
        expect(Vinted::ShipmentFactory.new("2015-12-10 D LP").shipment.class).to eq(Vinted::InvalidShipment)
      end
    end
    context "when provided invalid Shipping provider in string" do
      it "returns Invalid Shipment instance" do
        expect(Vinted::ShipmentFactory.new("2015-12-10 L LPS").shipment.class).to eq(Vinted::InvalidShipment)
      end
    end
    context "when provided valid string" do
      it "returns Shipment instance" do
        expect(Vinted::ShipmentFactory.new("2015-02-10 L LP").shipment.class).to eq(Vinted::Shipment)
        expect(Vinted::ShipmentFactory.new("2015-02-10 S MR").shipment.class).to eq(Vinted::Shipment)
        expect(Vinted::ShipmentFactory.new("2015-02-10 M MR").shipment.class).to eq(Vinted::Shipment)
      end
    end
  end
end
