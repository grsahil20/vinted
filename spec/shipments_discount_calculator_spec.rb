require "vinted/shipments_discount_calculator"
require "vinted/shipment"



describe Vinted::ShipmentsDiscountCalculator do

  def process_shipments(shipments, max_monthly_discount = nil)
    calculator = max_monthly_discount ? Vinted::ShipmentsDiscountCalculator.new(max_monthly_discount: max_monthly_discount) : Vinted::ShipmentsDiscountCalculator.new
    shipments.each do |shipment|
      calculator.add_shipment(shipment)
    end
    calculator.process
    shipments.map { |shipment| calculator.discount_for(shipment)}
  end

  describe '.result' do
    context "for MR shipment provider" do
      context "when provided S size shipments" do
        it 'returns with 0.50 discount' do
          shipments = [Vinted::Shipment.new('2015-02-01 S MR'), Vinted::Shipment.new('2015-02-02 S MR')]
          expect(process_shipments(shipments)).to eq([0.50, 0.50])
        end
      end
      context "when provided L size shipment" do
        it 'returns with 0.0 discount' do
          shipments = [Vinted::Shipment.new('2015-02-01 L MR')]
          expect(process_shipments(shipments)).to eq([0.0])
        end
      end
    end

    context "for LP shipment provider" do
      context "when provided S size shipments" do
        it 'returns with 0.0 discount' do
          shipments = [Vinted::Shipment.new('2015-02-01 S LP'), Vinted::Shipment.new('2015-02-02 S LP')]
          expect(process_shipments(shipments)).to eq([0.0, 0.0])
        end
      end
      context "when provided L size shipments" do
        it 'returns with discount only for 3rd shipment' do
          shipments = [
            Vinted::Shipment.new('2015-02-01 L LP'),
            Vinted::Shipment.new('2015-02-02 L LP'),
            Vinted::Shipment.new('2015-02-03 L LP'),
            Vinted::Shipment.new('2015-02-04 L LP'),
            Vinted::Shipment.new('2015-02-05 L LP'),
            Vinted::Shipment.new('2015-02-06 L LP'),
          ]
          expect(process_shipments(shipments)).to eq([0.0, 0.0, 6.9, 0.0, 0.0, 0.0])
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
          expect(process_shipments(shipments)).to eq([0.0, 0.0, 6.9, 0.0, 0.0, 6.9])
        end
      end
    end

    context "for mixed shipments" do
      context "when provided various size shipments" do
        it 'returns with no more than max allowed discount' do
          shipments = [
            Vinted::Shipment.new('2015-02-01 S MR'),
            Vinted::Shipment.new('2015-02-02 S LP'),
            Vinted::Shipment.new('2015-02-03 S MR'),
            Vinted::Shipment.new('2015-02-04 S MR'),
            Vinted::Shipment.new('2015-02-05 S MR'),
            Vinted::Shipment.new('2015-02-06 S MR'),
          ]
          expect(process_shipments(shipments, 1.00)).to eq([0.5, 0.0, 0.5, 0.0, 0.0, 0.0])
          expect(process_shipments(shipments, 10.00)).to eq([0.5, 0.0, 0.5, 0.5, 0.5, 0.5])
        end
      end
    end
  end

end
