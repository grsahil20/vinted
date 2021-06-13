require "vinted/shipments_processor"

describe Vinted::ShipmentsProcessor do

  describe "#min_cost_for_size" do
    it "returns relevnant lowest cost" do
      expect(Vinted::ShipmentsProcessor.min_cost_for_size(size: "S")).to eq(1.50)
      expect(Vinted::ShipmentsProcessor.min_cost_for_size(size: "M")).to eq(3.00)
      expect(Vinted::ShipmentsProcessor.min_cost_for_size(size: "L")).to eq(4.00)
    end
  end

end
