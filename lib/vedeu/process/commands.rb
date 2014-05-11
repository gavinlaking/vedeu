module Vedeu
  module Process
    class InvalidCommand < StandardError; end

    class Commands
      include Singleton

      class << self
        def instance(&block)
          @instance ||= new(&block)
        end
        alias_method :define, :instance

        def execute(keys = "")
          instance.execute(keys)
        end
      end

      def initialize(&block)
        @commands ||= { "exit" => Proc.new { puts "Exit called";exit! } }

        yield self if block_given?
      end

      def add(name, klass)
        commands[name] = Proc.new { klass.dispatch } unless invalid?(name, klass)
        commands
      end

      def show
        commands
      end

      def execute(name = "")
        return commands.fetch(keys).call unless invalid_name?(name)
      rescue KeyError
      end

      private
      attr_accessor :commands, :instance

      def invalid?(name, klass)
        raise InvalidCommand, "Name invalid."       if invalid_name?(name)
        raise InvalidCommand, "Class not defined."  if invalid_klass?(klass)
        raise InvalidCommand, "No dispatch method." if no_dispatch?(klass)
      end

      def invalid_name?(name)
        name.to_s.empty?
      end

      def invalid_klass?(klass)
        invalid_name?(klass) || undefined?(klass)
      end

      def no_dispatch?(klass)
        not klass.singleton_methods(false).include?(:dispatch)
      end

      def undefined?(klass)
        not Object.const_defined?(klass.to_s)
      end
    end
  end
end
