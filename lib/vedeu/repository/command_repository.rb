module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def by_keypress(input)
        command = query(klass, :keypress, input)

        return nil if command.nil? || command.is_a?(Hash)

        command
      end

      def by_keyword(input)
        command = query(klass, :keyword, input)

        return nil if command.nil? || command.is_a?(Hash)

        command
      end

      def klass
        Command
      end
    end
  end
end
