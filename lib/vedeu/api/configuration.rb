module Vedeu
  module API

    class Configuration

      def self.configure(&block)
        new(&block).configure
      end

      def initialize(&block)
      end

      def configure
      end

      private

    end

  end
end
