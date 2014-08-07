module Vedeu
  class DSLParser
    def self.parse(data)
      new(data).parse
    end

    def initialize(data)
      @data = data
    end

    def parse
      { interfaces: [ data ] }
    end

    private

    attr_reader :data
  end
end
