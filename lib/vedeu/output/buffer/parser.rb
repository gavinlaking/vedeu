module Vedeu
  module Buffer
    class Parser
      def initialize(composition)
        @composition = composition
      end

      def parse
        binding.pry
      end

      private

      attr_reader :composition
    end
  end
end
