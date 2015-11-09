module Vedeu

  module Templating

    # Converts an object or collection of objects into an encoded
    # String.
    #
    # @api private
    #
    class Encoder

      # @param (see #initialize)
      # @return [String]
      def self.process(data)
        new(data).process
      end

      # Returns a new instance of Vedeu::Templating::Encoder.
      #
      # @param data [Object]
      # @return [Vedeu::Templating::Encoder]
      def initialize(data)
        @data = data
      end

      # Converts an object or collection of objects into an encoded
      # String.
      #
      # @return [String]
      def process
        wrap
      end

      protected

      # @!attribute [r] data
      # @return [Object]
      attr_reader :data

      private

      # Adds delimiters to the start and end of the data.
      #
      # @return [String]
      def wrap
        "{{#{encode64}}}".freeze
      end

      # Encode the compressed, marshalled object or objects into a
      # Base64 string.
      #
      # @return [String]
      def encode64
        Base64.strict_encode64(compress)
      end

      # Compress the marshalled object or objects.
      #
      # @return [String]
      def compress
        Zlib::Deflate.deflate(marshal)
      end

      # Convert the object or objects into marshalled object(s).
      #
      # @return [String]
      def marshal
        Marshal.dump(data)
      end

    end # Encoder

  end # Templating

end # Vedeu
