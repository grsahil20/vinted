require_relative "./vinted/shipment"

module Vinted

  DEFAULT_FILE_NAME = 'input.txt'

  def self.run(file_name: )
    shipments = read_input_file(file_name)
    shipments.each do |shipment|
      p shipment
    end
  end

  def self.read_input_file(file_name)
    result = []
    file = File.open(File.join(ENV['PWD'], 'seed', (file_name || DEFAULT_FILE_NAME)))
    result = file.map { |line| Vinted::Shipment.new(line.strip.chomp) }
    file.close
    return result
  end
end
