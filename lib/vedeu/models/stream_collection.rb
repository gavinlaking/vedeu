require 'virtus'

require_relative 'stream'

module Vedeu
  class InvalidStream < StandardError; end

  class StreamCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      if values.is_a?(::String)
        [Stream.new({ text: values })]

      else
        [values].flatten.map { |value| Stream.new(value) }

      end
    end
  end
end
