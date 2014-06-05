module Vedeu
  class CommandRepository
    extend Repository

    class << self
      def execute(name, args = [])
        find(name).execute(*args)
      end

      def klass
        Command
      end
    end
  end
end
