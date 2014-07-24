require 'virtus'

require 'vedeu/models/attributes/collection'
require 'vedeu/models/stream'

module Vedeu
  class StreamCollection < Virtus::Attribute
    include Collection

    def coerce(values)
      coercer(values, Stream, :text)
    end
  end
end
