require_relative "./vinted/shipment"

module Vinted

  DEFAULT_FILE_NAME = 'input.txt'

  def self.run(file_name: )
    P file_name || DEFAULT_FILE_NAME
  end
end
