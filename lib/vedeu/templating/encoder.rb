module Vedeu

  module Templating

    class Encoder

      # @param data [Object]
      # @return [String]
      def self.process(data)
        new(data).process
      end

      # @param data [Object]
      # @return [Vedeu::Templating::Encoder]
      def initialize(data)
        @data = data
      end

      # @return [String]
      def process
        encode64
      end

      protected

      # @!attribute [r] data
      # @return [Object]
      attr_reader :data

      private

      # @return [String]
      def encode64
        Base64.strict_encode64(compress)
      end

      # @return [String]
      def compress
        Zlib::Deflate.deflate(marshal)
      end

      # @return [String]
      def marshal
        Marshal.dump(data)
      end

    end # Encoder

  end # Templating

end # Vedeu
