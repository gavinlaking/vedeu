module Vedeu
  class UndefinedInterface < StandardError; end

  class Interfaces
    class << self
      def default
        new { |io| io.add(:dummy, Dummy) }
      end

      def define(&block)
        new(&block)
      end
    end

    def initialize(&block)
      @interfaces ||= {}

      yield self if block_given?
    end

    def add(name, klass, options = {})
      if valid?(klass)
        interfaces[name] = Proc.new { klass.new(options) }
        interfaces
      end
    end

    def show
      interfaces
    end

    def initial
      interfaces.values.map { |io| io.call.initial }
    end

    def main
      interfaces.values.map { |io| io.call.main }
    end

    private

    attr_accessor :interfaces

    def valid?(klass)
      raise UndefinedInterface unless Object.const_defined?(klass.to_s)
      true
    end
  end
end
