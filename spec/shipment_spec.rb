require "vinted/shipment"

describe Vinted::Shipment do

  context "when provided valid string" do
    describe ".shipment_date" do
      it "returns matching shipment_date" do
        expect(Vinted::Shipment.new("2015-02-01 S MR").shipment_date).to eq(Time.strptime('2015-02-01', Vinted::Shipment::DATE_TIME_FORMAT))
      end
    end

    describe ".shipping_size" do
      it "returns matching shipping_size" do
        expect(Vinted::Shipment.new("2015-02-10 L LP").shipping_size).to eq('L')
        expect(Vinted::Shipment.new("2015-02-10 S MR").shipping_size).to eq("S")
        expect(Vinted::Shipment.new("2015-02-10 M MR").shipping_size).to eq("M")
      end
    end

    describe ".shipping_provider" do
      it "returns matching shipping_provider" do
        expect(Vinted::Shipment.new("2015-02-01 S MR").shipping_provider).to eq('MR')
        expect(Vinted::Shipment.new("2015-02-01 L LP").shipping_provider).to eq('LP')
      end
    end
  end
end
