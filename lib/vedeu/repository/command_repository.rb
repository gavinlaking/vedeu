module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def by_keypress(input)
        query(entity, :keypress, input)
      end

      def by_keyword(input)
        query(entity, :keyword, input)
      end

      def create(attributes)
        super(Command.new(attributes))
      end

      def entity
        Command
      end
    end
  end
end
