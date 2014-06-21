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

  # :nocov:
  module ClassMethods
    def command(name, entity, options = {})
      command_name = name.is_a?(Symbol) ? name.to_s : name

      CommandRepository.create({
        name:    command_name,
        entity:  entity,
        options: options
      })
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
  # :nocov:
end
