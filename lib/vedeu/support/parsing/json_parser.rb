require 'oj'

module Vedeu
  module JSONParser
    extend self

    def parse(output)
      Oj.load(output, symbol_keys: true)
    rescue Oj::ParseError
      {}
    end
  end
end
