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
      @commands ||= { 'exit' => Proc.new { Exit.dispatch } }

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

    attr_accessor :commands
    attr_accessor :instance

    def exists?(command)
      commands.fetch(command, false)
    end
  end

  class Exit
    def self.dispatch
      :stop
    end
  end
end
