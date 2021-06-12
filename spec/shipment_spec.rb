require "vinted/shipment"

describe Vinted::Shipment do
  describe ".valid?" do
    context "when provided invalid string" do
      it "returns valid as false" do
        expect(Vinted::Shipment.new("aaaa").valid?).to eq(false)
        expect(Vinted::Shipment.new("2015-02-29 CUSPS").valid?).to eq(false)
      end
    end
    context "when provided invalid date in string" do
      it "returns valid as false" do
        expect(Vinted::Shipment.new("2015-22-10 L LP").valid?).to eq(false)
      end
    end
    context "when provided invalid size in string" do
      it "returns valid as false" do
        expect(Vinted::Shipment.new("2015-12-10 D LP").valid?).to eq(false)
      end
    end
    context "when provided invalid Shipping provider in string" do
      it "returns valid as false" do
        expect(Vinted::Shipment.new("2015-12-10 L LPS").valid?).to eq(false)
      end
    end
    context "when provided valid string" do
      it "returns valid as true" do
        expect(Vinted::Shipment.new("2015-02-10 L LP").valid?).to eq(true)
        expect(Vinted::Shipment.new("2015-02-10 S MR").valid?).to eq(true)
        expect(Vinted::Shipment.new("2015-02-10 M MR").valid?).to eq(true)
      end
    end
  end

  describe ".shipment_date" do
    context "when provided valid string" do
      it "returns matching shipment_date" do
        expect(Vinted::Shipment.new("2015-02-01 S MR").shipment_date).to eq(Time.strptime('2015-02-01', Vinted::Shipment::DATE_TIME_FORMAT))
      end
    end
  end

  describe ".shipping_size" do
    context "when provided valid string" do
      it "returns matching shipping_size" do
       expect(Vinted::Shipment.new("2015-02-10 L LP").shipping_size).to eq('L')
        expect(Vinted::Shipment.new("2015-02-10 S MR").shipping_size).to eq("S")
        expect(Vinted::Shipment.new("2015-02-10 M MR").shipping_size).to eq("M")
      end
    end
  end

  describe ".shipping_provider" do
    context "when provided valid string" do
      it "returns matching shipping_provider" do
        expect(Vinted::Shipment.new("2015-02-01 S MR").shipping_provider).to eq('MR')
        expect(Vinted::Shipment.new("2015-02-01 L LP").shipping_provider).to eq('LP')
      end
    end
  end
end
