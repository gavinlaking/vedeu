module Vedeu

  module Templating

    class Decoder

      # @param data [String]
      # @return [Object]
      def self.process(data)
        new(data).process
      end

      # @param data [String]
      # @return [Vedeu::Templating::Decoder]
      def initialize(data)
        @data = data
      end

      # @return [Object]
      def process
        demarshal
      end

      protected

      # @!attribute [r] data
      # @return [String]
      attr_reader :data

      private

      # @return [Object]
      def demarshal
        Marshal.load(decompress)
      end

      # @return [String]
      def decompress
        Zlib::Inflate.inflate(decode64)
      end

      # @return [String]
      def decode64
        Base64.strict_decode64(data)
      end

    end # Decoder

  end # Templating

end # Vedeu
