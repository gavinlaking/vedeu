module Vedeu
  class InvalidCommand < StandardError; end

  class Command
    class << self
      def define(name, klass, args = [], options = {})
        new(name, klass, args, options).define
      end
    end

    def initialize(name, klass, args = [], options = {})
      @name, @klass, @args, @options = name, klass, args, options
    end

    def define
      { name => executable } if valid?
    end

    private

    attr_reader :name, :klass, :args, :options

    def executable
      Proc.new { klass.dispatch(*args, options) }
    end

    def valid?
      empty_name? || empty_klass? || klass_defined? || dispatch_defined? || true
    end

    def empty_name?
      raise InvalidCommand, "Command name is missing." if name.to_s.empty?
    end

    def empty_klass?
      raise InvalidCommand, "Command class is missing." if klass.to_s.empty?
    end

    def klass_defined?
      unless Object.const_defined?(klass.to_s)
        raise InvalidCommand, "Command class is not defined."
      end
    end

    def dispatch_defined?
      unless klass.singleton_methods(false).include?(:dispatch)
        raise InvalidCommand, "Command dispatch method is not defined."
      end
    end
  end
end
