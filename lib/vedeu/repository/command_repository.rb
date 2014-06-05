module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def define(&block)
        return self unless block_given?
        yield  self
      end

      def add(name, options = {})
        attributes = options.merge!({ name: name })

        command = klass.new(attributes)
        create(command)

        all
      end

      def execute(name, args = [])
        find(name).execute(*args)
      end

      def klass
        Command
      end
    end
  end
end
