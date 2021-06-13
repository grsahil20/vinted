require_relative './vinted/shipment_factory'
require_relative './vinted/shipments_processor'

module Vinted
  DEFAULT_FILE_NAME = 'input.txt'

  def self.run(file_name: )
    shipments = create_shipments_from_file(file_name)
    Vinted::ShipmentsProcessor.new(shipments: shipments).process
  end

  def self.create_shipments_from_file(file_name)
    result = []
    file = File.open(File.join(ENV['PWD'], 'seed', (file_name || DEFAULT_FILE_NAME)))
    file.map { |line| result << Vinted::ShipmentFactory.new(line.strip.chomp).shipment }
    file.close
    result
  end
end
