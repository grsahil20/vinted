require_relative "./vinted/invalid_shipment"
require_relative "./vinted/shipment"
require_relative "./vinted/shipment_factory"
require_relative "./vinted/shipment_cost"

module Vinted
  DEFAULT_FILE_NAME = 'input.txt'

  def self.run(file_name: )
    shipments = create_shipments_from_file(file_name)
    process_shipments(shipments)
  end

  def self.create_shipments_from_file(file_name)
    result = []
    file = File.open(File.join(ENV['PWD'], 'seed', (file_name || DEFAULT_FILE_NAME)))
    result = file.map { |line| Vinted::ShipmentFactory.new(line.strip.chomp).shipment }
    file.close
    return result
  end

  def self.process_shipments(shipments)
    Vinted::ShipmentsProcessor.new(shipments).process
  end
end
