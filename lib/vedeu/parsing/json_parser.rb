require 'json'

module Vedeu
  class JSONParser
    def self.parse(output)
      new(output).parse
    end

    def initialize(output)
      @output = output
    end

    def parse
      JSON.load(output, nil, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end

    private

    attr_reader :output
  end
end
