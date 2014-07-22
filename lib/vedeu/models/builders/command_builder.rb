require_relative '../../repository/command_repository'

module Vedeu
  class CommandBuilder
    def self.build(name, &block)
      new(name).build(&block)
    end

    def initialize(name)
      @name = name.to_s
    end

    def build(&block)
      self.instance_eval(&block)

      CommandRepository.create(attributes)
    end

    private

    attr_reader :name

    def attributes
      @attributes ||= { name: name }
    end

    def method_missing(method_name, arg, &block)
      attributes[method_name] = arg
    end
  end
end
