module Vedeu
  class Commands
    include Singleton

    class << self
      def instance(&block)
        @instance ||= new(&block)
      end
      alias_method :define, :instance

      # def define(name, klass, args = [], options = {}, &block)
      #   instance.define(name, klass, args = [], options = {})
      # end

      def execute(command = "")
        instance.execute(command)
      end

      def list
        instance.list
      end
    end

    def initialize(&block)
      @commands ||= {}

      yield self if block_given?
    end

    def define(name, klass, args = [], options = {})
      commands.merge!(Command.define(name, klass, args, options))
    end
    alias_method :add, :define

    def execute(command)
      commands.fetch(command).call if exists?(command)
    end

    def list
      commands.inspect
    end

    private

    attr_writer   :commands
    attr_accessor :instance

    def commands
      default_commands.merge!(@commands)
    end

    def default_commands
      {
        'exit' => Proc.new { Vedeu::Exit.dispatch }
      }
    end

    def exists?(command)
      commands.fetch(command, false)
    end
  end
end
