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
      Proc.new { klass.dispatch(*args) }
    end

    def valid?
      empty_name? || empty_klass? || klass_defined? || dispatch_defined? || true
    end

    def empty_name?
      invalid("Command name is missing.") if name.to_s.empty?
    end

    def empty_klass?
      invalid("Command class is missing.") if klass.to_s.empty?
    end

    def klass_defined?
      invalid("Command class is not defined.") unless is_class?
    end

    def dispatch_defined?
      invalid("Command dispatch method is not defined.") unless has_dispatch?
    end

    def is_class?
      Object.const_defined?(klass.to_s)
    end

    def has_dispatch?
      klass.singleton_methods(false).include?(:dispatch)
    end

    def invalid(message)
      raise InvalidCommand, message
    end
  end
end
