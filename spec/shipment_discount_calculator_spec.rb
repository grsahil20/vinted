require "vinted/shipments_discount_calculator"
require "vinted/shipment"

describe Vinted::ShipmentsDiscountCalculator do
  describe '.result' do
    context "for MR shipment provider" do
      context "when provided S size shipments" do
        it 'returns with 0.50 discount' do
          shipments = [Vinted::Shipment.new('2015-02-01 S MR'), Vinted::Shipment.new('2015-02-02 S MR')]
          calculator = Vinted::ShipmentsDiscountCalculator.new(shipments: shipments)
          calculator.process
          expect(calculator.discount_for(shipments[0])).to eq(0.50)
          expect(calculator.discount_for(shipments[1])).to eq(0.50)
        end
      end
      context "when provided L size shipment" do
        it 'returns with 0.0 discount' do
          shipment = Vinted::Shipment.new('2015-02-01 L MR')
          calculator = Vinted::ShipmentsDiscountCalculator.new(shipments: [shipment])
          calculator.process
          expect(calculator.discount_for(shipment)).to eq(0.0)
        end
      end
    end

    context "for LP shipment provider" do
      context "when provided S size shipments" do
        it 'returns with 0.0 discount' do
          shipments = [Vinted::Shipment.new('2015-02-01 S LP'), Vinted::Shipment.new('2015-02-02 S LP')]
          calculator = Vinted::ShipmentsDiscountCalculator.new(shipments: shipments)
          calculator.process
          expect(calculator.discount_for(shipments[0])).to eq(0.0)
          expect(calculator.discount_for(shipments[1])).to eq(0.0)
        end
      end
      context "when provided L size shipments" do
        it 'returns with discount only for 3rd shipment' do
          shipments = [
            Vinted::Shipment.new('2015-02-01 L LP'),
            Vinted::Shipment.new('2015-02-02 L LP'),
            Vinted::Shipment.new('2015-02-03 L LP'),
            Vinted::Shipment.new('2015-02-04 L LP')
          ]
          calculator = Vinted::ShipmentsDiscountCalculator.new(shipments: shipments)
          calculator.process
          expect(calculator.discount_for(shipments[0])).to eq(0.0)
          expect(calculator.discount_for(shipments[1])).to eq(0.0)
          expect(calculator.discount_for(shipments[2])).to eq(6.9)
          expect(calculator.discount_for(shipments[3])).to eq(0.0)
        end
        it 'returns with discount for every 3rd shipment every month' do
          shipments = [
            Vinted::Shipment.new('2015-02-01 L LP'),
            Vinted::Shipment.new('2015-02-02 L LP'),
            Vinted::Shipment.new('2015-02-03 L LP'),
            Vinted::Shipment.new('2015-03-01 L LP'),
            Vinted::Shipment.new('2015-03-02 L LP'),
            Vinted::Shipment.new('2015-03-03 L LP'),
          ]
          calculator = Vinted::ShipmentsDiscountCalculator.new(shipments: shipments)
          calculator.process
          expect(calculator.discount_for(shipments[0])).to eq(0.0)
          expect(calculator.discount_for(shipments[1])).to eq(0.0)
          expect(calculator.discount_for(shipments[2])).to eq(6.9)
          expect(calculator.discount_for(shipments[3])).to eq(0.0)
          expect(calculator.discount_for(shipments[4])).to eq(0.0)
          expect(calculator.discount_for(shipments[5])).to eq(6.9)
        end
      end
    end
  end
end
