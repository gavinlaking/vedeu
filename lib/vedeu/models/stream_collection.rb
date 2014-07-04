require 'virtus'

require_relative 'stream'
require_relative 'coercions'

module Vedeu
  class InvalidStream < StandardError; end

  class StreamCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return [] if empty?(values)

      if multiple?(values)
        values.map { |v| Stream.new(v) }
      elsif single?(values)
        [Stream.new(values)]
      elsif values.is_a?(String)
        [Stream.new({ text: values })]
      end
    end
  end
end
