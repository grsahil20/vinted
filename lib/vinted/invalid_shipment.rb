module Vinted
  class InvalidShipment
    attr_reader :str
    def initialize(str)
      @str = str
    end

    def valid?
      false
    end

    def print
      str
    end
  end
end
