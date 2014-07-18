require 'json'

module Vedeu
  module JSONParser
    extend self

    def parse(output)
      JSON.load(output, nil, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end
  end
end
