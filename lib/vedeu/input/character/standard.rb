module Vedeu
  module Input
    module Character
      class Standard
        def self.parse(stream)
          new(stream).encode
        end

        def initialize(stream)
          @stream = stream
        end

        def encode
          replace_carriage_returns.force_encoding('utf-8')
        end

        private

        attr_reader :stream

        def replace_carriage_returns
          signed_char.gsub("\r", "\n")
        end

        def signed_char
          stream.pack('c*')
        end
      end
    end
  end
end
