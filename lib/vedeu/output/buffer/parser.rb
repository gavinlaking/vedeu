module Vedeu
  module Buffer
    class Parser
      def initialize(composition)
        @composition = composition
      end

      def to_hash
        Oj.load(to_json)
      end

      def to_json
        Oj.dump(composition, mode: :compat, circular: true)
      end

      private

      attr_reader :composition
    end
  end
end
