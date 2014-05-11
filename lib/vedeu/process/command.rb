module Vedeu
  module Process
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
        raise InvalidCommand, "Command name is missing."      if empty_name?
        raise InvalidCommand, "Command class is missing."     if empty_klass?
        raise InvalidCommand, "Command class is not defined." unless klass_defined?
        raise InvalidCommand, "Command class is invalid."     unless dispatch_defined?
        true
      end

      def empty_name?
        name.to_s.empty?
      end

      def empty_klass?
        klass.to_s.empty?
      end

      def klass_defined?
        Object.const_defined?(klass.to_s)
      end

      def dispatch_defined?
        klass.singleton_methods(false).include?(:dispatch)
      end
    end
  end
end
