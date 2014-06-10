module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def find_by_input(input)
        return by_keypress(input) unless by_keypress(input) == {}
        return by_keyword(input)  unless by_keyword(input)  == {}
      end

      def klass
        Command
      end

      private

      def by_keypress(input)
        query(klass, :keypress, input)
      end

      def by_keyword(input)
        query(klass, :keyword, input)
      end
    end
  end
end
