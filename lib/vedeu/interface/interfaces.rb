module Vedeu
  class UndefinedInterface < StandardError; end

  module Interfaces
    extend self
    attr_accessor :interfaces

    def define(&block)
      if block_given?
        yield self
      else
        self
      end
    end

    def defined
      interfaces.empty? ? default : self
    end

    def list
      interfaces.inspect
    end

    def add(name, options = {}, klass = DummyInterface)
      interfaces[name] = klass.new(options) if valid?(klass)
      self
    end

    def reset
      @interfaces = {}
    end

    def find(name)
      interfaces[name] || nil
    end

    def initial_state
      interfaces.values.map { |io| io.initial_state }
    end

    def input
      interfaces.values.map { |io| io.input }
    end

    def output
      interfaces.values.map { |io| io.output }
    end

    private

    def valid?(klass)
      raise UndefinedInterface unless Object.const_defined?(klass.to_s)
      true
    end

    def default
      add(:dummy)

      self
    end

    def interfaces
      @interfaces ||= {}
    end
  end
end
