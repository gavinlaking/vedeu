require 'json'

module Vedeu
  class JSONParser
    def self.parse(json)
      new(json).parse
    end

    def initialize(json)
      @json = json
    end

    def parse
      JSON.load(json, nil, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end

    private

    attr_reader :json
  end
end
