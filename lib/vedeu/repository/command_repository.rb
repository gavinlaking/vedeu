module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def by_keypress(input)
        query(klass, :keypress, input)
      end

      def by_keyword(input)
        query(klass, :keyword, input)
      end

      def klass
        Command
      end
    end
  end
end
