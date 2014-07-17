require 'virtus'

require_relative 'collection'
require_relative 'stream'

module Vedeu
  class StreamCollection < Virtus::Attribute
    include Collection

    def coerce(values)
      coercer(values, Stream, :text)
    end
  end
end
