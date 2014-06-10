module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def find_by_input(input)
        return nil if input.nil? || input.empty?
        return by_keypress(input) if input.size == 1
        return by_keyword(input)  if input.size > 1
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
